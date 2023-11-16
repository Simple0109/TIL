Gemfileに`gem "devise_invitable`を追記 `$ bundle`実行

ターミナルで
`$ bundle exec rails g invitable:install`を実行

`$ bundle exec rails g devise_invitable 既存のdevise利用モデル名`を実行
例`$ bundle exec rails g devise_invitable User`
で
```
simple@shinpeinoMacBook-Air kimochi3 % bundle exec rails g devise_invitable User
      insert  app/models/user.rb
      invoke  active_record
      create    db/migrate/20231115052834_devise_invitable_add_to_users.rb
```
Userモデルが更新され、追加されるカラムのマイグレーションファイルが作成される

User.rb変更箇所
```ruby
class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

  validates :name, presence: true, length: { maximum: 20 }
  validates :role , presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 7 }, format: { with:VALID_PASSWORD_REGEX }

  enum role: { general: 0, admin: 1 }

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  
  # ここの :invitableが追加されている
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```

作成されたマイグレーションファイル
```ruby
class DeviseInvitableAddToUsers < ActiveRecord::Migration[7.0]
  def up
    change_table :users do |t|
      t.string     :invitation_token
      t.datetime   :invitation_created_at
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.references :invited_by, polymorphic: true
      t.integer    :invitations_count, default: 0
      t.index      :invitation_token, unique: true # for invitable
      t.index      :invited_by_id
    end
  end

  def down
    change_table :users do |t|
      t.remove_references :invited_by, polymorphic: true
      t.remove :invitations_count, :invitation_limit, :invitation_sent_at, :invitation_accepted_at, :invitation_token, :invitation_created_at
    end
  end
end
```

`$ bundle exec rails db:migrate`を実行

ビューを作成する
`$ bundle exec rails g devise_invitable:views`
作成されるファイル
```
simple@shinpeinoMacBook-Air kimochi3 % bundle exec rails generate devise_invitable:views
      invoke  DeviseInvitable::Generators::MailerViewsGenerator
       exist    app/views/devise/mailer
      create    app/views/devise/mailer/invitation_instructions.html.erb
      create    app/views/devise/mailer/invitation_instructions.text.erb
      invoke  form_for
      create    app/views/devise/invitations
      create    app/views/devise/invitations/edit.html.erb
      create    app/views/devise/invitations/new.html.erb
```
`edit.html.erb`は招待された人が自身のアカウントを作成するページ

## 注意
deviseを使ってUserモデルを作成し、nameカラム等を追加した場合
devise_invitableを使用して招待機能を実装しようしたとき、追加したカラム(仮に`name`)に
`validates :name, presence: true `のようなバリデーションを設定していると、devise_invitableのcreateアクション実行時にバリデーションエラーが発生する
原因としては被招待者のメールアドレスを招待者が入力し、送信する際に一度emailだけusersテーブルに保存される。その段階でバリデーションで弾かれてしまう
`presence`を設定しなければ回避できるが、マイグレーションファイルでnot_null制約をつけることはできるが、空白での登録は拒否できない
そのため、Userモデルはあくまでユーザー管理、nameやdescription等のユーザー情報についてはprofilesテーブルで管理することとした(11/16現在)