# devise
ログイン認証機能(ログイン、ログアウト機能)等を簡単に実装できるGem
その他にも[公式](https://github.com/heartcombo/devise)にかかれているように様々な機能がある
Database Authntucatable: サインイン時にユーザーの真正性を検証するために、パスワードをハッシュ化してデータベースに保存します。認証は POST リクエストや HTTP ベーシック認証の両方で行うことができます。
Omniauthable: OmniAuth (https://github.com/omniauth/omniauth) サポートを追加します。
Confirmable：確認の指示メールを送信し、サインイン時にアカウントが確認済みかどうかを検証します。
Recoverable：ユーザーパスワードをリセットし、リセットの指示を送信します。
Registerable（登録可能）：登録プロセスを通じてユーザーを登録し、アカウントの編集と破棄を可能にします。
Rememberable: 保存されたクッキーからユーザーを記憶するためのトークンの生成とクリアを管理します。
Trackable：サインイン数、タイムスタンプ、IPアドレスを追跡します。
Timeoutable（タイムアウト可能）: 指定された期間にアクティブでなかったセッションを失効させます。
Validatable: メールとパスワードのバリデーションを提供します。これはオプションであり、カスタマイズすることができますので、独自のバリデーションを定義することができます。
Lockable：サインインに失敗した回数が指定された場合、アカウントをロックします。電子メールまたは指定された期間後にロックを解除できます。

## 使い方
Gemfileに追記
```
gem "devise"
```
ターミナルで`$ rails g devise:install`を実行

通常、モデルを作成するときには`$ rails g model名 ~ `を実行するが
認証が使えるモデルを作成するときには`$ rails g devise model名`を実行する
このコマンドでモデルを作成するとログイン認証するためのファイルが自動で作成され、認証機能が使えるようになる
仮に`Userモデル`を作成するときには`$ rails g devise user`でを実行すればおk
これを実行すると`route.rb`に`devise_for :users`自動で追記される
この記述によってサインアップやログインなどの認証のためのルーティングが自動で作成される
**devise_for**
deviseのヘルパーメソッド
`:モデル名`を指定すると認証に必要なルーティングを自動で設定してくれる。この記述の追加と同時にマイグレーションファイルも作成される

### カラムを追加して、そのカラムを認証機能で使用する場合
自動で作成されたマイグレーションファイルの内容をみると`name`カラムについての記述がないため、`name`カラム等を追加したい場合、追記してから`$ rails db:migrate`すること
また追加したカラムを認証機能で使用する場合、追加したカラムをsign up時に変更許可する設定を行う必要がある
[認証カラムの追加について](https://github.com/heartcombo/devise#strong-parameters)

deviseのコントローラはライブラリで用意されているため直接変更ができないのでapplication_controllerに以下の記述を行う
```ruby
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  #以下の:name部分は追加したカラムに変える
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
```
`before_action :configure_permitted_parameters, if: :devise_controller?`
if文の条件(devise_controllerが呼び出されたら)を満たした時、実行前にconfigure_permitted_parametersアクションを実行

`devise_parameter_sanitizer.permit(:deviseの処理名, key: [:許可するカラム])`
`devise_parameter_sanitizer` -> sanitizerメソッドはUserモデルのパラメーター（情報）を取得するメソッド
`permit(:sign_up, key: [:name])` -> sign_up時にnameデータの操作を許可

**deviseの処理**
>There are just three actions in Devise that allow any set of parameters to be passed down to the model, therefore requiring sanitization. Their names and default permitted parameters are:
Deviseには3つのアクションがあり、どのようなパラメータのセットでもモデルに渡すことができるため、サニタイズが必要です。それらの名前とデフォルトで許可されるパラメータは以下の通りです：
>・sign_in (Devise::SessionsController#create) - Permits only the authentication keys (like email)
sign_in (Devise::SessionsController#create) - 認証キー（メールアドレスなど）のみを許可します。
>・sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password and password_confirmation
sign_up (Devise::RegistrationsController#create) - 認証キーとパスワード、password_confirmation を許可します。
>・account_update (Devise::RegistrationsController#update) - Permits authentication keys plus password, password_confirmation and current_password
account_update (Devise::RegistrationsController#update) - 認証キーとパスワード、password_confirmation、current_password の入力を許可する

上記をまとめるとdeviseコントローラが呼び出され時、nameの変更を許可する。といった内容

### ヘルパーメソッド
**`before_action:authenticate_user!`**
アクセス権限の設定をする。ログイン後のみアクセスできるページを作りたいときに設定する
viewでif文を使い、画面遷移のためのボタンをログインしていない場合には表示しないように設定すればいいように思えるが、この方法だとURLを直接入力すると画面遷移することができるので`before_action :authenticate_user!`をコントローに記述する必要がある
onlyで特定のアクションのみに設定したり、exceptで特定のアクションを除外することもできる

**`user_signed_in?`**
ユーザーがログインしているかどうか判定する
ユーザーがログインしていれば`true`が、ログアウトしていれば`false`が返される
ログイン時と非ログイン時でヘッダーの表示を変更する際にif文の条件として使用したりする

**`current_user`**
現在ログインしているユーザーをモデルオブジェクトとして利用できる
簡単に現在のユーザーのID等を取得できるため非常に便利(`current_user.id`)

**`user_session`**
ユーザーのセッション情報を設定・取得するためのメソッド

### 詳細設定
**パスワード文字列数の変更**
config/initializers/devise.rbファイルを開き`config.password_length = 6..128`の数値部分を変更する

### 会員登録機能実装
**nameカラムを追加し、新規登録に必要な項目としている場合**
初期状態のdeviseはサインアップ時に`email, password`しか受け取れない設定になっている
そのためnameカラム等を登録の際に必要な情報に加えるためのストロングパラメーターの設定を行わなければならない
deviseのコントローラは直接修正ができないため、全てのコントローラの設定を行えるapplication_controller.rbを修正
[編集できない理由](https://tomo-bb-aki0117115.hatenablog.com/entry/2020/09/28/235741)

application_controller.rb
```ruby
class ApplicationController < ActionController::Base
  # devise機能（登録やログイン認証等)を使う時は、configure_permitted_parametersメソッドを実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protectedとすることで他のコントローラーからも下記定義メソッドが他のコントローラでも使用可能になる
  protected

  # sign_up時にnameカラムのデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
  end
end
```
[公式ドキュメント](https://github.com/heartcombo/devise#strong-parameters)
なお`email`や`password`はデフォルトで認証されているので`[]`に入れる必要はない

**viewファイルを作成**
`rails g devise:views`を実行
deviseの機能と関連付けられたファイルが`app/views/devise`内に生成される

### ログイン時、ログアウト時の画面遷移先の変更
application_controller.rbに以下の記述を追加する
```ruby
class ApplicationController < ActionController::Base

  private

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    root_path  #ここを好きなパスに変更
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path #ここを好きなパスに変更
  end
end
```
deviseのソースコードに
・`after_sign_in_path_for(resource_or_scope)`
・`after_sign_out_path_for(resource_or_scope)`
という2つのメソッドが存在し、これをapplication_controller.rbでオーバーライドすることで
ログイン後、ログアウト後の画面遷移先を変更することができる
[公式ドキュメント](https://github.com/heartcombo/devise#controller-filters-and-helpers)
```
# after_sign_in_path_for と after_sign_out_path_for をオーバーライドしてリダイレクトフックをカスタマイズすることもできます。
You can also override after_sign_in_path_for and after_sign_out_path_for to customize your redirect hooks.
```

### rememberable
`$ rails g devise:views`で作成されたdevise/sessions/new.rb内をみると以下の記述がある
```ruby
<% if devise_mapping.rememberable? %>
  <div class="field">
    <%= f.check_box :remember_me %>
    <%= f.label :remember_me %>
  </div>
<% end %>
```
表示される画面をみるとチェックボックスとRemember meの記述がされている
このチェックボックスにチェックを入れてログインすると、次回からログイン情報を入力せずにログイン状態を保持することができる
`<% if devise_mapping.rememberable? %>`はrememberableモジュールがdeviseの設定に含まれているかを確認しているがその設定とはdeviseで作成したモデルに記述されている
```ruby
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
```
この記述を参考に判別を行なっている

### deviceのフォームで2つのモデルに同時に値を送る方法
UserモデルがProfileモデルを持っているという状況
※前提
・deviseインストール済
・deviceでUserモデル、usersテーブル作成済、Profileとアソシエーション設定済
・profileモデル、profilesテーブル作成済、Userとアソシエーション設定済

`$ rails g devise:controller users`でusers_controller.rbを作成
Userモデルを以下のようにprofileと関連付ける
```ruby
class User < ApplicationRecord
  has_one :profile #profileとuserの1対1の関連づけ
  accepts_nested_attributes_for :profile #ここ
end
```
`accepts_nested_attributes_for`によってUserモデルを通してProfileの属性の値をDBに保存することができる

ProfileモデルとUserモデルを関連づける
```ruby
class Profile <> ApplicationRecord
  belong_to :user
end
```

registrarion_controller.rbに`newアクション`を追加
```ruby
def new
  @user = User.new
  @profile = @user.profile_build
end
```
`build_profile`は@userが`has_one :profile`というアソシエーションを持っている場合
新しいProfileインスタンスを作成し@userとそのプロフィールを関連づける
この新しいプロフィールはまだデータベース保存されていない
@userが保存された直後@profileも保存される

ルーティングを編集する
```ruby
  devise_for :users, controllers: { registrations: 'users/registrations' }
```
deviseにはデフォルトの`registrationsコントローラ`があるが、それを今回のようにカスタムして使用する場合
`, controllers: { registrations: 'users/registrations' }`を追記しなければならない

ビューファイルの編集をする
```ruby
<%= form_with model:@user, url: user_registration_path, method: :post do |f| %>
  <%= f.fields_for :profile do |f| %>
    <div class="mb-6">
      <%= f.label :name, class: "block mb-2 text-sm text-gray-600 dark:text-gray-400" %><br />
      <%= f.text_field :name, autofocus: true, autocomplete: "name", placeholder: "らんてくん",
      class: "w-full px-3 py-2 placeholder-gray-300 border border-gray-300 rounded-md focus:outline-none focus:ring focus:ring-indigo-100 focus:border-indigo-300 dark:bg-gray-700 dark:text-white dark:placeholder-gray-500 dark:border-gray-600 dark:focus:ring-gray-900 dark:focus:border-gray-500" %>
    </div>
  <% end %>
  ...
<% end %>
```
class名とかは自己都合なので無視でおk
```ruby
  <%= f.fields_for :profile do |f| %>
    <div class="field">
      <%= f.label :name %><br />
      <%= f.text_field :name %>
    </div>
  <% end %>
```
のように`f.fields_for :profile do ~ end`を加える
これで`@profile`を`@user`にネストさせながら同じフォームで値を送信できる

ストロングパラメーターの編集
先述しているとおりdeviseは直接コントローラを編集できないので`application_controller.rb`を編集する
```ruby
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: [:name]])
  end
end
```
`before_action :configure_permitted_parameters, if: :devise_controller?`は、deviseコントローラーでアクションが実行される前に、指定されたメソッド（`configure_permitted_parameters`）を実行する

`devise_parameter_sanitizer.permit(:deviseの処理名, key: [:許可するカラム])`
`devise_parameter_sanitizer` -> sanitizerメソッドはUserモデルのパラメーター（情報）を取得するメソッド
`permit(:sign_up, key: [profile_attributes:[:name]])` -> sign_up時にprofileモデルのattributeであるnameデータの操作を許可

ユーザー登録ボタンを押した時の処理を確認すると
```shell
11:23:36 web.1  | Started POST "/users" for ::1 at 2023-11-17 11:23:36 +0900
11:23:36 web.1  | Processing by Users::RegistrationsController#create as HTML
11:23:36 web.1  |   Parameters: {"authenticity_token"=>"[FILTERED]", "user"=>{"profile_attributes"=>{"name"=>"てすとまん"}, "email"=>"test@example.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "commit"=>"Sign up"}
11:23:37 web.1  |   TRANSACTION (0.1ms)  BEGIN
11:23:37 web.1  |   User Exists? (0.4ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "test@example.com"], ["LIMIT", 1]]
11:23:37 web.1  |   User Create (0.5ms)  INSERT INTO "users" ("email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["email", "test@example.com"], ["encrypted_password", "[FILTERED]"], ["reset_password_token", "[FILTERED]"], ["reset_password_sent_at", "[FILTERED]"], ["remember_created_at", nil], ["created_at", "2023-11-17 02:23:37.105905"], ["updated_at", "2023-11-17 02:23:37.105905"]]
11:23:37 web.1  |   Profile Create (1.2ms)  INSERT INTO "profiles" ("name", "avatar", "role", "description", "user_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["name", "てすとまん"], ["avatar", nil], ["role", 0], ["description", nil], ["user_id", 4], ["created_at", "2023-11-17 02:23:37.107602"], ["updated_at", "2023-11-17 02:23:37.107602"]]
11:23:37 web.1  |   TRANSACTION (1.0ms)  COMMIT
11:23:37 web.1  | Redirected to http://localhost:3000/
11:23:37 web.1  | Completed 303 See Other in 423ms (ActiveRecord: 3.2ms | Allocations: 8694)
```
profile_attributesとしてnameを受け取り、userもprofileもcreateが成功している。

[参考サイト](https://qiita.com/HIROKOBA/items/35b636005311b8384278)