# devise_authenticatableを利用した招待機能の実装方法の流れ

前提`devise`インストール済

## Gem追加
Gemfileに`devise_token_authenticatable`を追加する
```ruby
gem "devise_token_authenticatable"
```
`$ bundle install`を実行

## Userモデルの設定
### Userモデルに`:token_authenticatable`を追加する
```ruby
class User < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```
`:token_authenticatable`はユーザーがログインしたときにトークンを生成し、それを利用してセッションを管理する機能を提供する

### マイグレーションを行う
`token_authenticatable`を使用するためにUserモデルに`authentication_token`を格納するカラムを追加する
`$ rails generate migration AddAuthenticationTokenToUsers authentication_token:string`
作成されたマイグレーションファイルを編集
```ruby
class AddAuthenticationTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authentication_token, :string
    add_index :users, :authentication_token, unique: true
  end
end
```
`$ rails db:migrate`実行

## 招待機能の実装
招待機能を実装するためにユーザーが招待を受け入れるためのリンクを生成し、そのリンクに`group_id`等の情報を含める
`$ rails g controller invitations`を実行し、`invitations_controller`を作成
```ruby
class InvitationsController < ApplicationController

  def new
  @invitation_link = new_user_registration_url(invitation_token: generate_invitation_token)
  end

  private

  def generate_invitation_token
    SecureRandom.urlsafe_base64(20)
  end
```
`generate_invitation_token`メソッドで20桁のトークンを生成している
`new`アクションでは`new_user_registration_url`でリンクを作成しそのリンクに引数として`generate_invitation_token`メソッドで作成したトークンを持たせている
`new_user_registration_url`にアクセスしてユーザーが新規登録した場合、`generate_invitation_token`メソッドで作られたトークンがそのユーザーの`authentication_token`カラムに保存される

### 招待トークン受け取り後の処理
```ruby
class InvitationsController < ApplicationController

  def 
  @invitation_link = new_user_registration_url(invitation_token: generate_invitation_token)
  end

  def accept_invitation
    invitation_token = params[:invitation_token]
    user = User.find_by(invitation_token: invitation_token)

    if user.present?
      group_id = user.invited_group.id
      GroupUser.create(user_id: user.id, group_id: group_id)

      user.update(invitation_token: nil)

      redirect_to root_path, notice: "招待を受け入れました"
    else
      redirect_to root_path, alert: "招待が無効です"
    end
  end

  private

  def generate_invitation_token
    SecureRandom.urlsafe_base64(20)
  end
```