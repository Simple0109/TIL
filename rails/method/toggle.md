### toggle
[ドキュメント](https://railsdoc.com/page/toggle)

属性に反対のブール値を割り当てる
```ruby
user = User.first
user.banned? #=> false
user.toggle(:banned)
user.banned? #=> true
```
※DBに保存はされない。保存したい場合は`save`メソッドを使うか`toggle!`を使う

### toggle!
```ruby
user = User.first
user.banned? #=> false
user.toggle!(:banned)
user.banned? #=> true
```