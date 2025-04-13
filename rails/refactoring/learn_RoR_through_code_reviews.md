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
