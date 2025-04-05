# クラス
内部にデータを保持し、さらに自分が保持しているデータを利用する独自のメソッドを持つことができる
データとそのデータに関するメソッドが常にセットになるので、クラスを使わない場合に比べてデータとメソッドの整理がしやすくなる

## オブジェクト指向型プログラミング関連の用語
- クラス
- オブジェクト
- インスタンス
- レシーバ
- メソッド
- メッセージ
- 状態（ステート）
- 属性（アトリビュート、プロパティ

### クラス
一種のデータ型。オブジェクトの設計図、オブジェクトの雛形と呼ばれる。
Rubyではオブジェクトは必ず何らかのクラスに属している。クラスが同じであれば保持している属性や使えるメソッドは原則同じ

### オブジェクト
クラスは設計図なので、それだけ持ってても仕方ない。車の設計書から赤い車や黒い車が作られるのと同じように
オブジェクト指向プログラミングではクラスから様々なオブジェクトが作成できる
同じクラスから作らられたオブジェクトは同じ属性（データ項目）やメソッドを持つが
属性の中に保持されるデータ（名前、数値、色など）はオブジェクトによって異なる
```ruby
class User
  attr_reader :first_name, :last_name, :age

  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end

alice = User.new("Alice", "Ruby", 20)
bob = User.new("Bob", "Python", 30)

# 同じメソッドを持つが、保持しているデータは異なるので出力が異なる
puts alice.full_name
#=> Alice Ruby

puts bob.full_name
#=> Bob Python
```
クラスをもとに作られたデータの塊を**オブジェクト**もしくは**インスタンス**と呼ぶ
「これはUserクラスのオブジェクトです」
「これはUserクラスのインスタンスです」
は同義

```ruby
user = User.new('Alice', "Ruby", 20)
user.full_name
```
このように`user`が``full_name`メソッドを使っている場合
「`first_name`メソッドのレシーバは`user`です」
と表現できる
メソッドを呼び出された側

### メソッド、メッセージ
オブジェクトが持つ「動作」や「振る舞い」をメソッドと呼ぶ
何らかの処理を1塊にして名前をつけ、何度も再利用できるようにしたもの
他の言語では「関数」「サブルーチン」と呼ぶ言語もある
```ruby
user = User.new('Alice', "Ruby", 20)
user.first_name
```
「2行目では`user`というレシーバに対して`first_name`というメッセージを送っている」
と表現することができる
※レシーバとメッセージという呼び方は`Smalltale`というオブジェクト指向言語でよく使われる呼び方でRubyも影響を受けている

### 状態
オブジェクトごとに保持されるデータのことを「オブジェクトの状態（またはステート）」と呼ぶことがある
例えば
信号機オブジェクトの現在の状態は赤です
といった感じ
Userクラスが持つ「名前」や「年齢」といったデータもオブジェクト指向の考え方でいくと「Userの状態」に含まれる

### 属性
オブジェクトの状態は外部から取得したり変更できる場合がある。
たとえば以下のコードはuserの名前（first_nama）を外部から取得したり、変更したりしている
```ruby
class User
  attr_accessor :first_name
  # 省略
end

user = User.new("Alice", "Ruby", 20)
user.first_name #=> "Alice"
user.first_name = "ありす"
user.first_name #=> "ありす"
```
## オブジェクトの作成とinitializeメソッド
クラスからオブジェクトを作成する場合、以下のように`initialize`メソッドを使う
```ruby
irb(main):262* class User
irb(main):263*   def initialize
irb(main):264*     puts "Initialized."
irb(main):265*   end
irb(main):266> end
irb(main):267> 
irb(main):268> User.new
Initialized.
=> #<User:0x000000012a0d2520>
```

`initialize`メソッドは特殊なメソッドでデフォルトで`private`メソッドになっている
```ruby
irb(main):270> user = User.new
Initialized.
=> #<User:0x0000000129ebdac8>
irb(main):271> user.initialize
(irb):271:in `<main>': private method `initialize' called for an instance of User (NoMethodError)
```

`initialize`メソッドに引数をとるとnewメソッドを呼ぶときに引数が必要になる
```ruby
class User
  def initialize(name, age)
    puts "name: #{name}, #{age}"
  end
end

User.new #=> (irb):273:in `initialize': wrong number of arguments (given 0, expected 2) (ArgumentError)
User.new("hgoe", 11) #=>  name: hoge, 11
```

クラス構文の内部でメソッドを定義するとそのメソッドは`インスタンスメソッド`になる
インスタンスメソッドはそのクラスのインスタンスに対して呼び出すことのできるメソッド
```ruby
class User
  def hello
    puts "Hello!"
  end
end

user = User.new
user.hello
#=> Hello!
```

クラス内部ではインスタンス変数を使うことができる
インスタンス変数とは同じインスタンスの内部で共有される変数
```ruby
class User
  def initialize(name)
    # インスタンス作成時に渡された名前をインスタンス変数に保持する
    @name = name
  end

  def hello
    puts "Hello, I am #{@name}"
  end
end

user = User.new("hoge")
user.hello
#=> "Hellom I am hoge"
```

インスタンス変数はクラスの外部から参照することができない
参照したい場合参照するためのメソッドを作る必要がある
```ruby
class User
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end
user = User.new("hoge")
pp user.name
#=> "hoge"
```
同じくインスタンス変数の内容を外部から変更したいときは、変更用のメソッドを定義しなければならない
```ruby
class User
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(value)
    @name = value
  end
end
user = User.new("hoge")
user.name
#=> "hgge"
user.name = "fuga"
user.name
#=> "fuga"
```
nameメソッドのように値を読み出すメソッドを`ゲッターメソッド`
name=メソッドのように値を書き込みメソッドを`セッターメソッド`
と呼ぶ
他の言語ではget_やset_といった接頭辞（プリフィックス）がつくことがあるがRubyではまれ
ゲッターメソッドとセッターメソッドを総称して`アクセサメソッド`と呼ぶ
Rubyの場合単純にインスタンス変数の内容を外部から読み書きするときは`attr_accessor`と呼ばれるメソッドを使って
ゲッター、セッターの定義を省略することができる
```ruby
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

user = User.new("hoge")
user.name #=> hoge
user.name = "fuga"
user.name #=> "fuga"
```
インスタンス変数の内容を読み取り専用にしたい場合は`attr_accessor`の代わりに`attr_reader`メソッドを使う
```ruby
class User
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

user = User.new("hoge")
user.name #=> hoge
user.name = "fuga" #=> undefined method `name=' for an instance of User (NoMethodError)
```
逆に書き込み専用にしたいときは`attr_writer`メソッドを使う
```ruby
class User
  attr_writer :name

  def initialize(name)
    @name = name
  end
end

user = User.new("hoge")
user.name #=> undefined method `name' for an instance of User (NoMethodError)
user.name = "fuga" #=> "fuga"
```
カンマで引数を増やすと複数のインスタンス変数に対するアクセサメソッドを定義することができる
```ruby
class User
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

user = User.new("hoge", 20)
user.name #=> "hoge"
user.age #=> 20
```

## クラスメソッド
ひとつひとつのインスタンスに含まれるデータは使わないメソッドを定義したい場合もある
その場合はクラスメソッドを定義したほうが使い勝手がいい
クラスメソッドを定義する1つの方法はメソッド名の前に`self.`をつけること
```ruby
class クラス名
  def self.クラスメソッド名
    # 処理
  end
end
```
もうひとつは`class << self`から`end`の間にメソッドを各方法
```ruby
class クラス名
  class << self
    def クラスメソッド名
      # 処理
    end
  end
end
```
クラスメソッドを呼び出すにはクラス名の直後に`.`をつける
`クラス名.クラスメソッド名`
```ruby
lass User
  def initialize(name)
    @name = name
  end

  def self.create_users(names)
    names.map do |name|
      User.new(name)
    end
  end

  def hello
    puts "Hello, I am #{@name}"
  end
end

names = ["hoge", "fuga", "isikawa"]
users = User.create_users(names)
users.each do |user|
  puts user.hello
end
#=> Hello, I am hoge
#=> Hello, I am fuga
#=> Hello, I am isikawa
```

## 改札機プログラムの作成

## selfキーワード
```ruby
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename_to_bob
    name = "Bob"
  end

  def rename_to_carol
    self.name = "Carol"
  end

  def rename_to_dave
    @name = "Dave"
  end
end
user = User.new("hoge")

user.rename_to_bob
user.name
#=> hoge

user.rename_to_carol
user.name
#=> Carol

user.rename_to_dave
user.name
#=> Dave
```
上のコードのように`rename_to_bob`だけはuserインスタンスのnameが変更されていない
これは以下のコードが原因
```ruby
def rename_to_bob
  name = "Bob"
end
```
このコードで定義している`name`はインスタンス変数ではなく、ローカル変数として扱われているため
よって`user.name`の値が`hoge`のままになっている
インスタンス変数に変更するためには
- @を使ったインスタンス変数で指定する
- self.をつける
を満たす必要がある

### クラスメソッドをインスタンスメソッドで呼び出す
`クラス名.メソッド名`
```ruby
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  # 金額を整形するクラスメソッド
  def self.format_price(price)
    "#{price}円"
  end

  def to_s
    # インスタンスメソッドからクラスメソッドを呼び出す
    formatted_price = Product.format_price(price)
    "name: #{name}, price: #{formatted_price}"
  end
end

product = Product.new("hoge", 110)
product.to_s
#=> "name: hoge, price: 10000円"
```

## クラスの継承
**サブクラス（子クラス）はスーパークラス（親クラス）の一種である**

### 標準ライブラリの継承関係
Rubyの継承は単一継承であり、継承できるスーパークラスは１つだけ
※ミックスインという多重継承に似た機能もある
```ruby
irb(main):005* class User
irb(main):006> end
=> nil
irb(main):007> user = User.new
=> #<User:0x0000000120938390>
irb(main):008> user.to_s
=> "#<User:0x0000000120938390>"
irb(main):009> user.nil?
=> false
irb(main):010> User.superclass
=> Object
```
このように中身が何も無いクラスも`to_s`メソッドや`nil?`メソッドが使えるのはスーパークラスに`Object`クラスであり継承しているから

以下のようにして`Object`クラスから継承したメソッドをみることができる
```ruby
irb(main):012> user.methods.sort
=> 
[:!,
 :!=,
 :!~,
 :<=>,
 :==,
 :===,
 :__id__,
 :__send__,
 :class,
 :clone,
 :define_singleton_method,
 :display,
 :dup,
 :enum_for,
 :eql?,
 :equal?,
 :extend,
 :freeze,
 :frozen?,
 :hash,
 :inspect,
 :instance_eval,
 :instance_exec,
 :instance_of?,
 :instance_variable_defined?,
 :instance_variable_get,
 :instance_variable_set,
 :instance_variables,
 :is_a?,
 :itself,
 :kind_of?,
 :method,
 :methods,
 :nil?,
 :object_id,
 :pretty_inspect,
 :pretty_print,
 :pretty_print_cycle,
 :pretty_print_inspect,
 :pretty_print_instance_variables,
 :private_methods,
 :protected_methods,
 :public_method,
 :public_methods,
 :public_send,
 :remove_instance_variable,
 :respond_to?,
 :send,
 :singleton_class,
 :singleton_method,
 :singleton_methods,
 :tap,
 :then,
 :to_enum,
 :to_s,
 :yield_self]
```

### オブジェクトのクラスの確認方法
```ruby
irb(main):002* class User
irb(main):003> end
=> nil
irb(main):004> user = User.new
=> #<User:0x000000011e73f568>
# user.classで確認できる
irb(main):005> user.class
=> User
# instance_of?(クラス名)でも確認できる
irb(main):006> user.instance_of?(User)
=> true
irb(main):007> user.instance_of?(String)
=> false
```
継承関係（is-a関係にあるかどうか）確認する場合は`is_a?`メソッドか`kind_of?`メソッドを使う
```ruby
irb(main):009> user.instance_of?(Object)
=> false
=> true
irb(main):012> user.is_a?(Object)
=> true
irb(main):014> user.is_a?(BasicObject)
=> true

# 継承関係にない場合はfalse
irb(main):015> user.is_a?(String)
=> false
```

### クラスの継承
```ruby
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class DVD < Product
  # nameとpriceはProduct（スーパークラス）でattr_readerが設定されているので定義不要
  attr_reader :running_time

  def initialize(name, price, running_time)
    @name = name
    @price = price
    @running_time = running_time
  end
end

dvd = DVD.new("A great movie", 1000, 120)
irb(main):022> dvd.name
=> "A great movie"
irb(main):023> dvd.name
=> "A great movie"
irb(main):024> dvd.price
=> 1000
irb(main):025> dvd.running_time
=> 120
```
このように書くことができる
しかしスーパークラスのinitializeメソッドで同じように値を入力しているので、まったく同じ処理を書くよりも
スーパークラスの処理を読んだほうがシンプル
こういう場合は`super`を使うとスーパークラスと同じメソッドを呼び出すことができる
```ruby
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class DVD < Product
  # nameとpriceはProduct（スーパークラス）でattr_readerが設定されているので定義不要
  attr_reader :running_time

  def initialize(name, price, running_time)
    # スーパークラスのinitializeを呼び出す
    super(name, price)
    @running_time = running_time
  end
end
```

サブクラスではスーパークラスと同名のメソッドを定義することで、スーパークラスの処理上書きすることができる
これをメソッドの**オーバーライド**という
`to_s`メソッドは`Object`クラスで定義されているので、ProductクラスやDVDクラスでto_sメソッドを呼び出すことが可能
```ruby
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class DVD < Product
  attr_reader :running_time

  def initialize(name, price, running_time)
    super(name, price)
    @running_time = running_time
  end
end

product = Product.new("A great movie", 1000)
product.to_s
#=> "#<Product:0x0000000120bba168>"

dvd = DVD.new("An Awesome film", 3000, 120)
dvd.to_s
#=> "#<DVD:0x000000011fdfa258>"
```
このようにto_sメソッドが呼び出せるが人間に優しいものではない。
わかりやすい文字列がかえってくるようにProductクラスでto_sメソッドをオーバーライドする
```ruby
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "name: #{name}, price: #{price}"
  end
end

class DVD < Product
  attr_reader :running_time

  def initialize(name, price, running_time)
    super(name, price)
    @running_time = running_time
  end
end

product = Product.new("A great movie", 1000)
puts product.to_s
#=> name: A great movie, price: 1000

dvd = DVD.new("An Awesome film", 3000, 120)
puts dvd.to_s
#=> name: An Awesome film, price: 3000
```
この状態だとDVDクラスで定義しているrunning_timeが表示されないのでもういっちょオーバーライドする
```ruby
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "name: #{name}, price: #{price}"
  end
end

class DVD < Product
  attr_reader :running_time

  def initialize(name, price, running_time)
    super(name, price)
    @running_time = running_time
  end

  def to_s
    "name: #{name}, price: #{price}, running_time: #{running_time} "
  end
end

product = Product.new("A great movie", 1000)
puts product.to_s

dvd = DVD.new("An Awesome film", 3000, 120)
puts dvd.to_s
#=> name: An Awesome film, price: 3000, running_time: 120 
```
商品名とクラス名はスーパークラスと同じなので、この部分はスーパークラスのメソッドを呼び出したほうがシンプル
```ruby
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "name: #{name}, price: #{price}"
  end
end

class DVD < Product
  attr_reader :running_time

  def initialize(name, price, running_time)
    super(name, price)
    @running_time = running_time
  end

  def to_s
    "#{super}, running_time: #{running_time} "
  end
end

product = Product.new("A great movie", 1000)
puts product.to_s

dvd = DVD.new("An Awesome film", 3000, 120)
puts dvd.to_s
#=> name: An Awesome film, price: 3000, running_time: 120 
```
このようにサブクラスではスーパークラスの差分をコーディングするだけでOK

### クラスメソッドの継承
クラスを継承すると、クラスメソッドも継承される
```ruby

class Foo
  def self.hello
    "hello"
  end
end

class Bar < Foo
end
irb(main):117> Foo.hello
#=> => "hello"
irb(main):118> Bar.hello
#=> => "hello"
```

## メソッドの可視性
Rubyのメソッドには以下の３つがある
- public
- protected
- private

### publicメソッド
クラスの外部からでも自由に呼び出せるメソッド
`initialize`メソッド以外のメソッドはデフォルトで`public`メソッドになる
```ruby
irb(main):001* class User
irb(main):002*   def hello
irb(main):003*     "Hello!"
irb(main):004*   end
irb(main):005> end
=> :hello
irb(main):006> user = User.new
=> #<User:0x000000011f4f9640>
irb(main):007> user.hello
=> "Hello!"
```

### privateメソッド
クラス内でprivateキーワードを書くとそこから下で定義されたメソッドはprivateメソッドになる
クラスの外からは呼び出せず、クラスの内部でのみ使えるメソッド（レシーバがselfに限定される）となる
```ruby
irb(main):001* class User
irb(main):002*   private
irb(main):003*   def hello
irb(main):004*     "Hello!"
irb(main):005*   end
irb(main):006> end
=> :hello
irb(main):007> user = User.new
=> #<User:0x000000010368a728>
irb(main):008> user.hello
(irb):8:in `<main>': private method `hello' called for an instance of User (NoMethodError)
```

### privateメソッドはサブクラスでも呼び出せる
他の言語ではprivateメソッドはそのクラスの内部でのみ呼び出せることが多いが
Rubyではそのクラスだけではなくサブクラスでも呼び出せる
```ruby
irb(main):001* class Product
irb(main):002*   private
irb(main):003*   def name
irb(main):004*     "A great movie"
irb(main):005*   end
irb(main):006> end
=> :name
irb(main):007* class DVD < Product
irb(main):008*   def to_s
irb(main):009*     "name: #{name}"
irb(main):010*   end
irb(main):011> end 
=> :to_s
irb(main):012> dvd = DVD.new
=> #<DVD:0x00000001016945e0>
irb(main):014> dvd.to_s
=> "name: A great movie"
```
スーパークラスのprivateメソッドが呼び出せるということはオーバーライドもできるということ
```ruby
class  Product
  def to_s
    "name: #{name}"
  end

  private

  def name
    "A great movie"
  end
end

class DVD < Product
  private

  def name
    "An awesome film"
  end
end

# Productクラスのto_sメソッド
product = Product.new
puts product.to_s

# DVDクラスのto_sメソッド
dvd = DVD.new
puts dvd.to_s
#=> name: A great movie
#=> name: An awesome film
```

サブクラスでメソッドをオーバーライドすると可視性も同時に変更できる
意図せず可視性を変更しないように注意が必要
```ruby
class  Product
  private

  def name
    "A great movie"
  end
end

class DVD < Product
  public

  def name
    "An awesome film"
  end
end

# nameメソッドはprivateのためエラーが起きる
product = Product.new
# puts product.name
#=> private method `name' called for an instance of Product (NoMethodError)

# DVDクラスではpublicメソッドになっているため呼び出せる
dvd = DVD.new
puts dvd.name
#=> An awesome film
```

※クラスメソッドはprivateにならず、インスタンスメソッドのみがprivateになる
クラスメソッドをprivateにしたい場合は`class << self`の構文を使う
```ruby
irb(main):001* class User
irb(main):002*   class << self
irb(main):003*     private
irb(main):004*     def hello
irb(main):005*       "Hello"
irb(main):006*     end
irb(main):007*   end
irb(main):008> end
=> :hello
irb(main):009> User.hello
(irb):9:in `<main>': private method `hello' called for class User (NoMethodError)
```

privateメソッドの引数つぃてメソッドを渡した場合、渡されたメソッドがprivateになる
```ruby
irb(main):001* class User
irb(main):002*   def foo
irb(main):003*     "Foo"
irb(main):004*   end
irb(main):005*   def bar
irb(main):006*     "Bar"
irb(main):007*   end
irb(main):008*   private :foo, :bar
irb(main):009*   def baz
irb(main):010*     "Baz"
irb(main):011*   end
irb(main):012> end
=> :baz
irb(main):013> user = User.new
=> #<User:0x00000001053d8d48>
# fooとbarはプライベートメソッドなので呼び出せない
irb(main):014> user.foo
(irb):14:in `<main>': private method `foo' called for an instance of User (NoMethodError)
irb(main):015> user.bar
(irb):15:in `<main>': private method `bar' called for an instance of User (NoMethodError)
# bazはいける
irb(main):016> user.baz
=> "Baz"
```

## 定数
定数はクラスの外部から参照可能
`クラス名::定数名`
```ruby
irb(main):028* class Product
irb(main):029*   DEFAULT_PRICE = 0
irb(main):030> end
=> 0
irb(main):031> Product::DEFAULT_PRICE
=> 0
```

定数を外部から参照させたくない場合は`private_constant`で定数を指定する
```ruby
irb(main):001* class Product
irb(main):002*   DEFAULT_PRICE = 0
irb(main):003*   private_constant :DEFAULT_PRICE
irb(main):004> end
=> Product
irb(main):005> Product::DEFAULT_PRICE
(irb):5:in `<main>': private constant Product::DEFAULT_PRICE referenced (NameError)
```
Rubyではメソッド内にスコープを限定した定数は定義できない
そのため定数の定義は必ずクラス構文の直下、もしくはトップレベルで行う必要がある
```ruby
irb(main):001> SOME_VALUE = 123
=> 123
irb(main):002* class Product
irb(main):003*   DEFAULT_PRICE = 0
irb(main):004> end
=> 0
```
Rubyの定数定義はそれ自体が値を返す
こえｒを利用して配列で定数を定義しつつ、その要素も同時に定数として定義することが可能
```ruby
rb(main):010* class TrafficLight
irb(main):011*   COLORS = [
irb(main):012*     GREEN = 0,
irb(main):013*     YELLOW = 1,
irb(main):014*     RED = 2
irb(main):015*   ]
irb(main):016> end
=> [0, 1, 2]
irb(main):017> TrafficLight::GREEN
=> 0
irb(main):018> TrafficLight::YELLOW
=> 1
irb(main):019> TrafficLight::RED
=> 2
irb(main):020> TrafficLight::CLORS
```
定数にはリテラルで作られる性的な値だけではなく、メソッドや条件分岐を使った動的な値も代入可能
```ruby
irb(main):026> NUMBERS = [1,2,3].map {|n| n * 10}
=> [10, 20, 30]
```

