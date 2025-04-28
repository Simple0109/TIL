# 配列操作メソッド
## 要素取得系
### sample
配列からランダムに1つ要素を取り出す
```ruby
irb(main):001> [1,2,3,4,5,6].sample
=> 2
irb(main):002> [1,2,3,4,5,6].sample
=> 1
```

### values_at
[instance method Array#values_at](https://docs.ruby-lang.org/ja/latest/method/Array/i/values_at.html)
配列から不連続の複数の値を取り出せる
```ruby
irb(main):005> ary = ['Apple', 'Orange', 'Strawberry', 'Banana']
irb(main):006> a, b, c = ary[0], ary[1], ary[4]
=> ["Apple", "Orange", nil]
```
通常上記のように`ary`から1つずつ要素を取得しなければならないが`values_at`メソッドを使うことで1行でかける
```ruby
irb(main):011> ary = ['Apple', 'Orange', 'Strawberry', 'Banana']
irb(main):012> ary.values_at(0,3,4)
=> ["Apple", "Banana", nil]
```

### assoc
[instance method Array#assoc](https://docs.ruby-lang.org/ja/latest/method/Array/i/assoc.html)
特定のキーを持つ要素を返す。ハッシュにしておけば簡単に指定
```ruby
irb(main):016> ary = [[:Apple, 100], [:Orange, 50], [:Strawberry, 200]]
=> [[:Apple, 100], [:Orange, 50], [:Strawberry, 200]]
irb(main):017> ary.assoc(:Orange)
=> [:Orange, 50]
```