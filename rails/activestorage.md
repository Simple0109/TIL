## active_storage
railsでファイルアップロードを扱うためのフレームワーク
画像やドキュメントなどのファイルをrailsアプリに添付できるようになる
またactives_storageはがAmazon S3、Google Cloud Storageなどのクラウドストレージサービスや
ローカルディスクにファイルを保存するためのインターフェースも提供している
これにより「開発環境ではローカルに保存」「本番環境ではクラウドに保存」といったふうな設定も簡単に行える

画像ファイルの場合は画像のリサイズや変換の処理もactive_storageで行うことができる
これは画像処理ライブラリである`imageMagick`や`image-processing`に依存している部分もあるからインストールしておく必要がある

[Railsガイド ActiveStorage](https://railsguides.jp/active_storage_overview.html)

## 使い方
### ActiveStorageのインストール
`$ rails active_storage:install`でActive Storageをインストールする
`$ rails db:migrate`を実行
実行することで`active_storage_blobs`と`active_storage_attachments`という2のテーブルが作成される
`active_storage_blobs`はアップロードファイルのメタ情報を管理するテーブル
`active_storage_attachments`はActive Storageと関連づいたモデルと`active_storage_blobs`の中間テーブル

Gemfileでコメントアウトされている`image-processing`のコメントアウトを外して`$ bundle`を実行する
すると
```ruby
image_processing (1.12.2)
  mini_magick (>= 4.9.5, < 5)
  ruby-vips (>= 2.0.17, < 3)
```
`mini-magick`と`vips`に依存しているのがわかる。この2つのうちどちらかのgemを使って画像のリサイズや回転等の画像処理を行う

`mini_magick`
Rubyで画像処理を行うためのGemです。画像のリサイズ、トリミング、フィルター処理など、様々な画像操作を行うことができます。ImageMagickという画像処理のライブラリをラップしており、RubyからImageMagickの機能を利用できるようにしています。

`vips`
VIPSは、高速でメモリ効率が高い画像処理ライブラリです。mini_magickと同様に、画像のリサイズ、回転、フィルター処理などを行うことができます。mini_magickよりも高速であり、大量の画像を効率的に処理する際に特に有用です。

以下railsガイド内容
```
Active Storageでは、バリアントプロセッサとしてVipsまたはMiniMagickを利用できます。デフォルトで使われるバリアントプロセッサはconfig.load_defaultsのターゲットバージョンに依存し、config.active_storage.variant_processorで変更できます。
```

どちらのバリアントプロセッサを使うかは`config/environments/development.rb`で指定することができる
```ruby
Rails.application.configure do
#　デフォルト
config.active_storage.variant_processsor = :vips

config.active_storage.variant_processsor = :mini_magick
```
### mini_magickとvipsのインストール
`mini_magick`と`vips`をインストールする
`$ brew install imagemagick`
`$ brew install libvips`

### 画像を添付したいカラムがあるモデルにアソシエーションを追加する
```ruby
class Profile < applicationRecord
  has_one_attached :avatar #添付したいファイルが単数の場合
  has_many_attached :avatar #添付したいファイルが複数の場合
```
### avatarにバリデーションを追加する
ActiveStorageはデフォルトでバリデーションの設定ができない
そのため自身でバリデーションを作る方法もあるが`activestorage-validator`というgemを使えば簡単にバリデーションを設定することができる
Gemfileに`gem activestorage-validator`を記述し`$ bundle`
[activestorage-validator wiki](https://github.com/aki77/activestorage-validator)
自分は以下のようにバリデーションを追加した
```ruby
  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
```
`presence`を設定することも可能だが、必ずavatarを添付しないといけないわけではないのでこのようにした
`content_type:`でファイル形式を画像ファイル(png, jpeg, jpeg)のみとし、画像ファイルのサイズを1~5MBに指定した
正直なんMBが適正がわからないので、あとで調整しないとって感じ

仮に自分でバリデーションを作るとしたら下記のような感じ
```ruby
class Profile < ApplicationRecord
...
  has_one_attached :avatar
  validate :image_content_type
  validate :image_size
  
    def image_content_type
    if avatar.attached? && !avatar.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, '：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。')
    end
  end

  def image_size
    if avatar.attached? && avatar.blob.byte_size > 1.megabytes
      errors.add(:image, '：1MB以下のファイルをアップロードしてください。')
    end
  end
end
```
`attached?`は特定のUserがアバター画像を持っているかを調べられる
特定のユーザーにアバター画像を添付したい場合は`attach`を使う
`user.avatar.attach(params[:avatar])`

### ストロングパラメーターを追加する
今回は元々アバター画像を添付しようと思っていたのでprofiles_controller.rbに下記のとおり作成済みだった
```ruby
  def profile_params
    params.require(:profile).permit(:name, :avatar, :description)
  end
```
もし`has_many_attached`を利用して複数枚の画像を取得する場合は以下のように記述しなけえればならない
`params.require(:profile).permit(:name, :description, :avatar, avatars: [])`
複数枚アップロードされた画像ファイルを配列に保持し、表示するときに`each文`を使用して表示させる

### フォームにアップローダーフィールドを追加する
app/views/profiles/edit.html.erbから抜粋（単数の場合）
```html
<div class="lg:max-w-lg lg:w-full md:w-1/2 w-5/6 mb-10 md:mb-0">
  <%= f.file_field :avatar, class: "object-cover object-center rounded" %>
</div>
```
複数枚の場合の例
```ruby
<div class="my-3">
  <%= f.label :avatar%><br>
  <%= f.file_field :avatars, multiple: true %>
</div>
```

### ビューに画像を表示させる
app/views/profiles/show.html.erbから抜粋
```html
<div class="lg:max-w-lg lg:w-full md:w-1/2 w-5/6 mb-10 md:mb-0">
  <%= image_tag(@profile.avatar)%>
</div>
```
複数枚の場合の例
```ruby
<% if profile.avatars.attached? %>
  <% profile.avatars.each do |avatar| %>
     <div><%= image_tag(avatar) %></div>
  <% end %>
<% end %>
```

### 画像処理機能
今回はマイページに表示される画像のサイズを一律にしたかったため`resize`を使おうと思ったがアップロードされた画像の縦横比を変更したくなかったため`resize_to_limit`を使用することとした
以下ろぼらんてくんによるresizeとresize_to_limitの違い解説
```ruby
resize_to_limitとresizeはActiveStorageの画像変換メソッドで、どちらも画像サイズの変更に使われるが、動作が少し異なるナ。

resize_to_limitメソッドは、指定した幅と高さの最大値を超えないように画像をリサイズするゾ。画像の縦横比はそのままに、指定したサイズに収まるように調整されるダ。例えば、resize_to_limit: [100, 100]と指定すると、元の画像がそれより大きい場合は100x100ピクセル以下にリサイズされるが、元の画像が小さい場合は何も変更されないナ。

一方で、resizeメソッドは、指定した幅と高さの値に従って画像をリサイズするダ。このメソッドでは縦横比が保たれず、指定したサイズぴったりに画像が変形される可能性があるゾ。つまり、resize: "100x100"と指定した場合、元の画像の縦横比に関わらず、強制的に100x100ピクセルのサイズにリサイズされるダナ。

要は、resize_to_limitは画像の比率を保ちつつ最大限のサイズに収める、resizeは指定したサイズに強制的に合わせる、という違いがあるゾ。
```

profile.rbに`avatar_thumbnail`メソッドを作成
```ruby
  def avatar_thumbnail
    avatar.variant(resize_to_limit: [1200, 400]).processed
  end
```
ActiveStorageでは`processed`メソッドを呼び出すことで、画像処理が完了していることを保証し、その結果を取得できる
後述するか`<%= image_tag(@profile.avatar_thumbnail)%>`とすることでリサイズされた画像を表示する
`processed`をつけなかった場合、画像処理の完了が保証されないため、リサイズ前の画像が表示される、もしくは画像が表示されない可能性がある
show.html.erbに以下の記述を追加
```ruby
<div class="flex justify-center items-start lg:max-w-lg lg:w-full md:w-1/2 w-5/6 mb-10 md:mb-0">
  <%= image_tag(@profile.avatar_thumbnail)%>
</div>

#前提として以下で@userと@profileを指定している
#def set_current_user_profile
#  @user = current_user
#   @profile = @user.profile
#end
```
これによりprofileにavatarが登録されている場合、リサイズされた画像が表示される
edit.html.erbに以下の記述を追加
```ruby
<div class="lg:max-w-lg lg:w-full md:w-1/2 w-5/6 mb-10 md:mb-0">
  <% if @profile.avatar.attached? %>
      <%= image_tag(@profile.avatar_thumbnail)%>
  <% end %>
  <%= f.file_field :avatar, class: "object-cover object-center rounded" %>
</div>
```

### デフォルト画像の設定