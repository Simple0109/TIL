# FatModel / FatController
modelやcontrollerが肥大化（コード行数が多くなったり、責務を超えたコードがかかれる）すること

これを防ぐためのアプローチの解説

## Module
Rubyの基本機能
関連するメソッドや、定数をグループ化するためのもの
```ruby
module PriceCalculator
  def calculator_price_with_tax(price)
    price * 1.1
  end
end

class Product < ApplicationRecord
 include PriceCalculator
end
```
適切な使用場面：複数クラスで共有される純粋な機能を抽出する場合

## Helperクラス
主にビューに関連するロジックをコントローラーから分離するために使用される
```ruby
# app/helpers/users_helper.rb
module UsersHelper
  def format_user_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
```
具体例
```ruby
# app/helpers/application_helper.rb
module ApplicationHelper
  def format_date(date, format = :default)
    return unless date
    
    case format
    when :short
      date.strftime("%Y/%m/%d")
    when :long
      date.strftime("%Y年%m月%d日 %H時%M分")
    when :relative
      time_ago_in_words(date) + "前"
    else
      l(date, format: :default)
    end
  end
  
  def status_badge(status)
    status_classes = {
      'pending' => 'badge-warning',
      'active' => 'badge-success',
      'inactive' => 'badge-danger'
    }
    
    content_tag :span, status.humanize, class: "badge #{status_classes[status] || 'badge-secondary'}"
  end
end

# ビューでの使用例 (show.html.erb)
<div class="user-info">
  <p>登録日: <%= format_date(@user.created_at, :long) %></p>
  <p>最終ログイン: <%= format_date(@user.last_login_at, :relative) %></p>
  <p>ステータス: <%= status_badge(@user.status) %></p>
</div>
```
適切な使用場面：ビューに関連する表示ロジックを分離する場合。

## Models/Concern
`ActiveSupport::Concern`を使用して実装されるモジュールを拡張したもの
モデル間で共通の振る舞いを共有するのに向いている
```ruby
# app/models/concerns/searchable.rb
module Searchable
  extend ActiveSupport::Concern

  include do
    scope :search, ->(query) { where("name LIKE ?", "%#{query}") }
  end

  class_methods do
        def advanced_search(criteria)
      # 複雑な検索ロジック
    end
  end
end

class Product < ApplicationRecord
  include Searchable
end
```

具体例1
```ruby
# app/models/concerns/soft_deletable.rb
module SoftDeletable
  extend ActiveSupport::Concern

  included do
    # スコープ：クエリをメソッドとして定義
    # :active -> 削除されていないレコードを取得するスコープ
    scope :active, -> { where(deleted_at: nil) }
    # :deleted -> 削除されたレコードを取得するメソッド
    scope :deleted, -> { where.not(deleted_at: nil) }
    
    # デフォルトスコープを設定して通常のクエリでは削除済みレコードを含めない
    default_scope { active }
  end

  # 論理削除を実行するメソッド
  def soft_delete
    update(deleted_at: Time.current)
  end

  # 論理削除を取り消すメソッド
  def restore
    update(deleted_at: nil)
  end

  # 削除済みかどうかを確認するメソッド
  def deleted?
    deleted_at.present?
  end
end

# 使用方法
class User < ApplicationRecord
  include SoftDeletable
  # deleted_atカラムが必要です
end

# 使用例
user = User.find(1)
user.soft_delete  # ユーザーを論理削除する
User.all          # 削除されていないユーザーのみ取得
User.deleted      # 削除済みユーザーを取得
user.restore      # 論理削除を取り消す
```
具体例2
```ruby
# app/models/concerns/statusable.rb
module Statusable
  extend ActiveSupport::Concern

  included do
    enum status: { draft: 0, published: 1, archived: 2 }
    
    scope :published_only, -> { where(status: :published) }
    scope :not_archived, -> { where.not(status: :archived) }
  end

  # 公開ステータスに変更
  def publish
    update(status: :published)
  end

  # アーカイブステータスに変更
  def archive
    update(status: :archived)
  end

  # 下書きステータスに変更
  def unpublish
    update(status: :draft)
  end
end

# 使用方法
class Post < ApplicationRecord
  include Statusable
  # statusカラム（integer型）が必要です
end

# 使用例
post = Post.find(1)
post.publish         # 公開状態に変更
Post.published_only  # 公開済み記事のみ取得
post.archived?       # アーカイブ状態かどうか確認
```
適切な使用場面：モデル間で共有される振る舞い（バリデーション、スコープ、コールバックなど）を抽出する場合。

## Controller/Concern
コントローラー用の Concern もモデルと同様に、コントローラー間で共有される機能を抽出するのに使用
```ruby
# app/controllers/concerns/authenticatable.rb
module Authenticatable
  extend ActiveSupport::Concern
  
  included do
    before_action :require_login
  end
  
  private
  
  def require_login
    redirect_to login_path unless current_user
  end
end

class UsersController < ApplicationController
  include Authenticatable
end
```

具体例1
```ruby
# app/controllers/concerns/simple_authentication.rb
module SimpleAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_login
    # ERBなどのビューファイルからも呼び出せるようにするための記述
    helper_method :current_user, :logged_in?
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:alert] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end

# 使用方法
class ApplicationController < ActionController::Base
  include SimpleAuthentication
end

# 認証が不要なコントローラー
class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      login(user)
      redirect_to root_path
    else
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to login_path
  end
end
```
具体例2
```ruby
# app/controllers/concerns/response_formatter.rb
module ResponseFormatter
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  end

  private
  
  def respond_with_success(resource, options = {})
    respond_to do |format|
      format.html { redirect_to options[:redirect_path] || resource, notice: options[:notice] || "操作が成功しました" }
      format.json { render json: resource, status: :ok }
    end
  end
  
  def respond_with_error(resource, options = {})
    respond_to do |format|
      format.html do
        flash.now[:alert] = options[:alert] || "エラーが発生しました"
        render options[:render] || :new
      end
      format.json { render json: { errors: resource.errors }, status: :unprocessable_entity }
    end
  end
  
  def handle_not_found
    respond_to do |format|
      format.html { 
        flash[:alert] = "リソースが見つかりませんでした"
        redirect_to root_path 
      }
      format.json { render json: { error: "リソースが見つかりませんでした" }, status: :not_found }
    end
  end
end

# 使用方法
class ProductsController < ApplicationController
  include ResponseFormatter
  
  def create
    @product = Product.new(product_params)
    
    if @product.save
      respond_with_success(@product, notice: "商品が作成されました")
    else
      respond_with_error(@product)
    end
  end
end
```
適切な使用場面：複数のコントローラーで共有されるフィルターやヘルパーメソッドを抽出する場合。

## Services
複雑なビジネスロジックを分離するために使用する一般的な名称
Rails及びRubyの公式機能ではない
```ruby
# app/services/order_processor.rb
class OrderProcessor
  def initialize(order)
    @order = order
  end
  
  def process
    validate_inventory
    charge_customer
    update_inventory
    send_confirmation
  end
  
  private
  
  def validate_inventory
    # 在庫確認ロジック
  end
  
  # その他のメソッド
end
```