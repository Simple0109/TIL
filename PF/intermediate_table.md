### 中間テーブルのデータ保存
user.rb
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
  has_many :request_approvals
  has_many :request, through: :request_approvals
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
```

group.rb
```ruby
class Group < ApplicationRecord
  validates :name, presence: true
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
end
```

group_user.rb
```ruby
class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
```

上記のようなアソシエーションを設定しているときusersテーブルとgroupsテーブルの中間テーブルであるgroup_usersにデータを保存するにはgroups_controller.rbのcreateアクションを以下のように記述しなければならない
```ruby
  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      redirect_to root_path
    else
      render :new
    end
  end
```
`@group.users << current_user`このように記述することで作られた@groupにcurrent_userの情報が入り自動的にgroup_usersテーブルに情報が保存される
