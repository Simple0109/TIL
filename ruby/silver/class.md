### Struct
`Struct（構造体クラス）`はRubyの標準ライブラリの一部。属性（アトリビュート）の集まりを持つクラスを生成するための機能
`Struct`クラスでは属性のゲッターとセッターを自動的に定義するため、単純なデータを素早く作成できる。
```ruby
irb(main):001> Person = Struct.new(:name, :age)
=> Person
irb(main):002> person = Person.new("山田太郎", 31)
=> #<struct Person name="山田太郎", age=31>
irb(main):003> puts person.name
山田太郎
=> nil
irb(main):004> puts person.age
31
=> nil
irb(main):005> person.age = 100
=> 100
irb(main):006> puts person.age
100
=> nil
```
`Struct`は変数に格納されている値で比較されるため、同じ属性値を持つ別々のStructインスタンスは`==`で比較すると`true`になる
```ruby
irb(main):001> Person = Struct.new(:name, :age)
=> Person
irb(main):002> p1 = Person.new("山田太郎", 30)
=> #<struct Person name="山田太郎", age=30>
irb(main):003> p2 = Person.new("山田太郎", 30)
=> #<struct Person name="山田太郎", age=30>
irb(main):004> puts p1 == p2
true
=> nil
```
