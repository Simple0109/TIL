# コードレビューで学ぶRuby on Rails
## Model
### 中間テーブルのモデルは関係性を表す命名にする
```ruby
class UserMagazine < ApplicationRecord
  belongs_to :user
  belongs_to :magazine
end
```
- 関連の意味が不明瞭
関連の構造名は表せているが、意味が表せていない。UserがMagazineを購読するのであれば`Subscription`などの命名のほうがふさわしい。

購読開始日や、購読費用などを表すとき脳内変化が必要になる
```ruby
user_magazine = UserMagazine.new
# user_magazine -> 購読だからstarted_onは購読開始日だなという脳内変化が必要
user_magazine.fee # 購読費用
user_magazine.started_on # 購読開始

# subscriptionであれば脳内変化不要
subscription = SubScription.new
subscription.fee # 購読費用
subscription.started_on # 購読開始日
```
- 同じ関連で異なる目的のモデル命名が衝突する
Userごとにお気に入りのMagazineを管理したいときも同じ中間テーブル名になってしまう
```ruby
# 購読管理モデル
class UserMagazine < ApplicationRecord
  belongs_to :user
  belongs_to :magazine
end

# お気に入り管理モデル
class UserMagazine < ApplicationRecord
  belongs_to :user
  belongs_to :magazine
end
```
これを避けるために`favorite`などの命名にする
```ruby
class Favorite < ApplicationRecord
belongs_to :user
belongs_to :magazine
end
```
### 一般ユーザーと管理者ユーザーでモデルを分けるべき
一般ユーザーと管理者ユーザーを分けるときたいてい以下の方法が取られる
- 一般ユーザーと管理者ユーザーを同じモデルで扱い、管理者フラグで管理する
-  一般ユーザーと管理者ユーザーを別モデルで扱う


-> 基本的にモデルを分けたほうがいい
- 判定ロジックの誤りによるセキュリティ問題を引き起こしやすい
- 一般ユーザーと管理者では要件が異なることが多い


一般ユーザーと管理者ユーザーのモデルを分けることで、管理者のコントローラーで`devise`などのロジックを宣言的に記述するだけで足りる
```ruby
class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!
end
```
※一般ユーザーが管理者ユーザーに昇格するような仕組みがある場合はこの限りではない

### データベース制約を設定する
```ruby
class CreateUser< ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
```
バリデーションでnot null制約をかけたりユニーク制約することも可能だが、バリデーションはあくまでアプリケーションのレベルの制約でありスキップできる

not null制約やユニーク制約は更に低レイヤーのデータベースレベルの制約のため信頼性がある
```ruby
class AddStatusToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :status, :integer, null: false, default: 0
  end
end
```
```ruby
class AddIndexToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :index, :integer, null: false, unique: true
  end
end
```

### scopeではActiveRecord::Relationを返す
[ActiveREcord::Relationとは](https://www.docswell.com/s/pink_bangbi/K88ELK-2022-10-22-133810#p1)

### dependent: :destroyは適切か？
```ruby
class User < ApplicationRecord
  has_many :orders, dependent: :destroy
end
```
ユーザーが消えたときに注文履歴も一緒に消えてしまった場合、売上集計が狂ってしまいそう

`:restrict_with_exception`オプションを使うことで親レコードを削除する際に、子レコードが存在すると例外を投げてくれるため意図せずデータを消してしまうおそれがない
```ruby
class User < ApplicationRecord
  has_many :orders, dependent: :restrict_with_exception
end
```
親レコードを削除し、子レコードを存在させたい場合、そもそも、親がなければ子は存在しなかった訳で、親レコードだけ削除して子レコードを削除しない運用は、システム矛盾を誘発する

これには、削除に代わるステータスをきちんと定義して、親レコードを削除しない解決策もある。例えば、ユーザーレコードなら「退会」ステータ  スを定義して、レコードを削除する運用を廃止するべき
```ruby
class User < ApplicationRecord
  has_many :orders dependent: :restrict_with_exception

  enum :status, [:active, :retired]

  def retired!
    # 退会処理
  end
```

### ループ処理の中でクエリを発行するような処理は避ける
N+1クエリ問題はRails開発でよく起きること。ループ処理の中でクエリを発行するような処理(`order, where, exist?, count`)は避けたほうがよい

## View
### Viewに複雑なロジックを書かない
```html
<span class="book_status">
  <% if @book.status == "draft" %>
    下書き
  <% elsif @book.status == "published" %>
    公開
  <% elsif @book.status == "end_of_sale" %>
    販売終了
  <% else %>
    その他
  <% end %>
</span>
```
ビューは手続き的処理を各場所ではなく、処理した結果を表示するためのもの。ビューの代わりにロジックを各場所はActionViewヘルパーなどに書く

**ActionViewヘルパー**

Rails標準のActionViewヘルパーはRailsが最初から用意してくれて、ビューのどこからでも呼び出せる
```ruby
module BookHelper
  def book_status_text(book)
    case book.status
    when "draft"
      "下書き"
    when "published"
      "公開" 
    when "end_of_sale"
      "販売終了"
    else
      "そのた"
    end
  end
end
```
そうするとビューは以下のようにスッキリかける
```html
<span class="book_status">
  <%= book_status_text(@book) %>
</span>
```
### コンポーネントのルート要素は１つにする
```ruby
# app/components/room_component.html.erb
<h1><%= room.name %></h1>

<div class="my-4">
  <a href="#">メニュー1</a>
  <a href="#">メニュー2</a>
  <a href="#">メニュー3</a>
  <a href="#">メニュー4</a>
</div>

<div>
  <%= room.description %>
</div>
```
コンポーネントを1つの要素にしたほうが外部クラス（呼び出しもと）の影響を受けづらい
```ruby
# 呼び出し例
<div style="display: flex; flex-direction: column; gap: 20px">
  <div>  --- ヘッダー ---  </div>
  <%= render 'component', root: room %> 
  <div>  --- フッター ---  </div> 
</div>
```
このような呼び出されると親要素の`gap: 20px`の影響をコンポーネントも受けてしまう
なので以下のように1つのルート要素に舌方が良い
```ruby
<div>
  <h1><%= room.name %></h1>

  <div class="my-4">
    <a href="#">メニュー1</a>
    <a href="#">メニュー2</a>
    <a href="#">メニュー3</a>
    <a href="#">メニュー4</a>
  </div>

  <div>
    <%= room.description %>
  </div>
</div>
```

### 詳細というリンクは作らない
不要なDOMが増える。それなら対象のタイトルやアバター画像またはカード全体をクリッカブルにするほうが、特にモバイルにおいてユーザー体験がいい

### パーシャルのルート要素にマージンを使わない
パーシャルのルート要素にマージン要素を含めると、親コンポーネントのレイアウトスタイルに作用してしまう。
呼び出し元でマージンを調整したいときにパーシャルのマージンも考慮しなければいけなくなる。面倒。
```ruby
# app/views/layouts/_navbar.html.erb
<div class="my-4"> 
  <div class="collapse navbar-collapse">
    ...
  </div>
</div>
```

であればパーシャルでは名0陣を持たせずに呼び出し元で調整したほうが考えることがすくなって楽

## controller
### resourcesを使ってRESTfulなルーティングをする


### コントローラーにモデルの知識は持たせない
```ruby
class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    order_items_params.each do |item_params|
      @order.order_items.build(item_params)
    end

    if @order.save
      redirect_to @order notice: "注文を完了しました"
    else
      render :new
    end
  end
  # ...
end
```
コントローラーでやり過ぎ感。コントローラーの責務はリクエストを処理して、適切なレスポンスを返すこと

コントローラー内の処理はリクエストの処理とレスポンスの準備に限定して、データ操作はモデルに以上するのが適切
```ruby
class OrdersController < ApplicationController
  def create
    order = Order.build_with_items(order_params, order_items_params)
    if order.save
      redirect_to order, notice: "注文が完了しました"
    else
      render :new
    end
  end
end

class Order < ApplicationRecord
  def self.build_with_items(order_params, order_items_params)
    order = Order.new(order_params)
    items_params.each do |item|
      order.order_items.build(item)
    end
    order
  end
end
```

### 名前空間ごとに基底コントローラーを作る
```ruby
class Books::PagesController < ApplicationController
  before_action :set_book
  before_action :set_page, only: [:show, :edit, :update, :delete]

  def index
    @pages = @book.pages.default_order
  end

  # ...

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_page
    @page = @book.pages.find(params[:id])
  end
```
このコントローラーは`pages_controller`だがPageが所属する親モデルのBookを取得するコードも混じっている

1つのコントローラーにPageとBookの複数の関心事が存在しておりSOLID原則でいうところの単一責任の原則から外れている

仮に著者（Author）一覧ページを作るときこのように作ると新たにAuthorControllerでも同じようにBookを取得するコードが必要になってしまう
```ruby
class Books::AuthorsController < ApplicationController
  before_action :set_book

  #...

  private

  def set_book
    @book = Book.find(params[:id])
  end

  # ...
end
```
既存のコードは`Books::PagesController`と密結合になっていて再利用できないためDRYでない

**基底クラスとしてBooks::ApplicationControllerを作成する**

`Books::ApplicationController`を作成して処理を共通化させることが必要
```ruby
class Books::ApplicationController < ApplicationController
  before_actinon :set_book

  private

  def set_book
    @book = Book.find(params[:id])
  end
end

class Books::PagesController < BooksApplicationController
  before_action :set_page, only: [:show, :edit, :update, :delete]
 
  def index
    @pages = @book.pages.default_order
  end

  # ...

  private

  def set_page
    @page = @book.pages.find(params[:id])
  end
end
```

### セッションの利用は最小限に
RailsデフォルトのセッションストアのCookiesStoreのセッションサイズは4KBの上限がある

ActiveRecordのインスタンスを丸々保存したりするとすぐにいっぱいになってしまう。よってセッションに保存するデータは必要最低限にすべき

**セッションに保存する値はidやキーのみにする**
**サーバー側に処理を集める**
**そもそもセッションにデータを保存しない**

### 一覧を取得する際にはorderをつける
ORDER句をつけていないSQLは順番が保証されていないため、表示するたび違う順番になる可能性がある

**順番が固定されるようにorderをつける**
```ruby
# これだと同じ公開日の場合の順番が不定になる
order(:published_on)

# idを表示順に加えることで必ず固定される
order(:published_on, :id)
```

### ルーティングをネストしたらmoduleも設定する
```ruby
# config/routes.rb
resources :books do
  resources :authors
end
```
ネストしたリソースを定義する場合、moduleオプションを指定しないとURLとコントローラーの構造が一致しなくなる。例のコードだと`/books/:book_id/authors`のURLが定義されているがコントローラーファイルは`app/controllers/authors_controller.rb`に配置される。URLはbooksにauthorsがネストしているのに対して、コントローラーはそうなっていないため修正すべきファイルがどこにあるかわからりづらくなる

また同盟リソースが複数ある場合、moduleオプションなしでは、すべてのリクエストを1つのAuthorsControllerで処理することになってしまう。`/books/authors/`と`/magazines/authors`の2つのURLが存在する場合、1つのコントローラーないでURLによって分岐して処理しなくてはならない

**moduleオプションをるけて名前空間をわける**
```ruby
# config/routes.rb
resources :books do
  resources :authors, module: :books
end

resources :magazines do
  resources :authors, module: :books
end
```

### 管理者と一般ユーザーのnamespaceは分ける
```ruby
class BooksController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]

  def index
    @books =
    if admin_signed_in?
      Book.default_order
    else
      Book.published,default_order
    end
  end

  #...
end
```
上記のように同一コントローラーを別々のユーザーが使ってコントローラーの中にif分岐が現れるようになったら要注意

コントローラーの政務が不適切になっている可能性がある
```ruby
# admin領域
namespace :admins do
  resources :books
end

# admin領域のコントローラー
class Admins::ApplicationController < ApplicationController
  before :authenticate_admin!
end

class Admins::BooksController < Admins::ApplicationController
  def index
    # この時点でadminであることが保証されている
  end
end
```

### 単一のリソースにはresourceを使う


```ruby
# config/routes.rb
Rails.application.routes.draw do
  # ...
  resources :users, only: [:show]
end

# app/controllers/users_controller.rb
class UsersController <ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    if params[:id].to_i != current_user.id
      redirect_to user_path(@user)
    end
  end
end
```
マイページのようなユーザーから見て単一となるリソースは`resources`ではなく`resource`を使うのが望ましい
```ruby
# config/routes.rb
Rails.application.routes.draw do
  # ...
  resource :mypage, only: [:show]
end

# app/controllers/users_controller.rb
class MypageController <ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
  end
end
```
URL用のヘルパーメソッドの呼び出しが冗長になるだけではなく、サポートページなどでマイページなどのリンクを提示できないという具体的なもんだいも生じるため`resource`を使うのが望ましい

## その他
### YAGNI
```ruby
class Order < ApplicationRecord
  belongs_to :user
  has_many :payments
end

class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user
end
```

```ruby
class BooksController <ApplicationController
  before_action :set_book
  before_action :create_first_page_for_book!

  #...

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def create_first_page_for_book!
    @book.pages.crate!(title: "First Pages")
  end
end
```