### マジックコメント
ソースファイルの文字コードを指定する
Ruby2.0であればデフォルトでUTF-8が入っている
以下のように書くことでマジックコードを指定できる
```ruby
# encoding: utf-8
# coding: utf-8

# encoding: Shift_JIS
# cording: Shift_JIS
```
マジックコメントは`coding: エンコーディング名`が正しければその前後に任意の文字を並べることができる
大文字、小文字の区別はない

### 数値リテラル
先頭に`0`がつく整数リテラルは__8進数__として解釈される

### Rubyにおける定数
アルファベット大文字で始まる識別子 `Abc, ABc, ABC`
Rubyで一度定義した定数に再び代入を行おうとすると**警告が発生する**が**値は変更することができる**
```shell
irb(main):001> MAX=10
=> 10
irb(main):002> print MAX
10=> nil
irb(main):003> MAX=100
(irb):3: warning: already initialized constant MAX
(irb):1: warning: previous definition of MAX was here
=> 100
irb(main):004> print MAX
100=> nil
```

### ローカル変数、グローバル変数、インスタンス変数、クラス変数、定数
**ローカル変数**
先頭は小文字またはアンダースコアで始める
```ruby
def some_method
  local_variable = "これはローカル変数です"
  puts local_variable
end
some_variable
```
**グローバル変数**
先頭に`$`をつける
プログラムのどこからでも参照可能
```ruby
$global_variable = "これはグローバル変数です"
def access_global
  puts $global_variable
  $global_variable = "変更"
end
puts $global_variable
access_global
puts $global_variable
#=> これはグローバル変数です
#=> これはグローバル変数です
#=> 変更
```
**インスタンス変数**
先頭に`@`をつける
クラスのインスタンスごとに固有の値を持つ
クラス内の全メソッドから参照可能
```ruby
class Person
  def initialize(name)
    @name = name
  end

  def greet
    puts "こんにちは、#{@name}さん"
  end

  def change_name(new_name)
    @name = new_name
  end
end

person = Person.new("田中")
person.greet
person.change_name("石川")
person.greet
#=> こんにちは、田中さん
#=> こんにちは、石川さん
```
**クラス変数**
先頭に`@@`をつける
クラスとそのサブクラスの全インスタンス間で共有される
クラスメソッドからも参照可能
```ruby
class Counter
  @@count = 0

  def initialize
    @@count += 1
  end

  def self.count
    @@count
  end

  def report
    puts "現在のカウント: #{@@count}"
  end
end

puts Counter.count
c1 = Counter.new
puts Counter.count
c2 = Counter.new
puts Counter.count
c1.report
#=> 0
#=> 1
#=> 2
#=> 現在のカウント: 2
```

### attr_reader
仮にrubyでUserクラスを定義するときそのクラスの持ち物（プロパティ）として
`name, email, address, age`
を持たせたいとき
```ruby
class User
  def initialize(name, email, address, age)
    @name = name
    @email = email
    @address = address
    @age = age
  end
end
```
このように定義する必要がある
`name, email, address, age`はUserクラスを定義するために必須のもの（モデルみたいなもの？）
Rubyはこのままの状態ではクラス外からクラスで定義したプロパティにアクセスができないためアクセス専用のメソッドを作る必要がある
```ruby
class User
  def initialize(name, email, address, age)
    @name = name
    @email = email
    @address = address
    @age = age
  end

  def name
    @name
  end

  def email
    @email
  end

  def address
    @address
  end

  def age
    @age
  end
end
```

しかしこのように書くのは可読性を低くするため以下のように書くことができる
```ruby
class User
  attr_reader :name, :email, :address, :age
  def initialize(name, email, address, age)
    @name = name
    @email = email
    @address = address
    @age = age
  end
end
```

### super
`super`は親クラスの同名メソッドを呼び出す
1. `super` : 現在のメソッドと同名の親クラスメソッドを呼び出して、現在のメソッドに渡された引数をそのまま親メソッドにわたす
2. `super()` : 引数なしで親クラスの同名メソッドを呼び出す
3. `super(arg1, arg2)` : 指定した引数で親クラスの同名メソッドを呼び出す
```ruby
# 引数指定なし
class Parent
  def greet(name)
    puts "Hello, #{name}"
  end
end

class Child < Parent
  def greet(name)
    puts "こんにちは、最初の挨拶"
    super
    puts "こんにちは、もう一度"
  end
end

Child.new.greet("alex")
#=> こんにちは、最初の挨拶
#=> Hello, alex
#=> こんにちは、もう一度

# 引数指定
class Parent
  def greet(name)
    puts "Hello, #{name}"
  end
end

class Child < Parent
  def greet(name)
    puts "こんにちは、最初の挨拶"
    super("石川")
    puts "こんにちは、もう一度"
  end
end

Child.new.greet("alex")
#=> こんにちは、最初の挨拶
#=> Hello, 石川
#=> こんにちは、もう一度
```

### モジュール
組み込みライブラリの一部としてモジュールが存在する
モジュールで定義されているメソッドの使用方法は以下の通り
`モジュール名.メソッド名`
```ruby
Math.sqrt(4) #=> 2.0
```
`include モジュール名`
```ruby
include Math
sqrt(4) #=> 2.0
```
`extend モジュール名`
```ruby
class Calculator
  extend Math
end
Calculator.sqrt(4) #=> 2.0
```
モジュールで定義されている定数へのアクセスする方法は以下のとおり
`モジュール名::定数名`
```ruby
Math::PI # => 3.141592653589793
```
`include モジュール名`
```ruby
include Math
PI # => 3.141592653589793
```

### オーバーライドできる演算子、できない演算子
オーバーライドできない演算子
```ruby
= ?: .. ... not && and || or ::
```
- 代入関連:`=`および`+=`,`-=`などの自己代入演算子：オブジェクトの参照を変更する根本的な操作
- 論理演算・制御フロー:`&&`,`and`,`||`,`or`,`not`,`?:(三項演算子)`：制御フローに関わるため変更できない
- 言語構造に関わるもの:`..`, `...`(範囲演算子), `::(スコープ解決演算子)`：名前空間へのアクセス方法



他にも`+=`などの自己代入演算子はオーバーライドできない
オーバーライドできる演算子
```ruby
|  ^  &  <=>  ==  ===  =~  >   >=  <   <=   <<  >>
+  -  *  /    %   **   ~   +@  -@  []  []=  ` ! != !~
```
[演算子式] (https://docs.ruby-lang.org/ja/latest/doc/spec=2foperator.html)

### Rubyのメソッド定義と優先順位
Rubyでは特定のオブジェクトに直接定義したメソッド（シングルトンメソッド）は
そのオブジェクトのクラスに定義されたメソッド（インスタンスメソッド）よりも湯煎される。
```ruby
s = "Hello"
def s.greet
  puts "Hi!"
end

class String
  def greet
    puts "Hello!"
  end
end

s.greet
```
上記のコードは
1. `s = Hello`で文字オブジェクトを作成
2. `def s.greet`で変数sが参照する特定の文字列オブジェクトにのみ適用される`greet`メソッドを作成している（シングルトンメソッド）
3. `class String`内で定義した`greet`メソッドはすべてのStringオブジェクトに適用されるメソッド（インスタンス・メソッド）
4. `s.greet`を実行するとRubyはまず`s`オブジェクト自身に定義されたメソッドを探し、見つかるとそれを実行する
```ruby
s = "Hello"
t = "World"  # 別の文字列オブジェクト

def s.greet
  puts "Hi!"
end

class String
  def greet
    puts "Hello!"
  end
end

s.greet  # => "Hi!" (シングルトンメソッドが呼ばれる)
t.greet  # => "Hello!" (クラスのインスタンスメソッドが呼ばれる)
```

### カスタムクラスのオブジェクトをソートするには
```ruby
class Employee
  attr_reader :id
  attr_accessor :name
  def initialize(id, name)
    @id = id
    @name = name
  end

  def to_s
    return "#{@id}:#{@name}"
  end

  # これがないとEmployeeクラスのオブジェクトを比較できない
  def <=> other
    return self.id <=> other.id
  end
end

employees = []
employees << Employee.new("3", "Tanaka")
employees << Employee.new("1", "Suzuki")
employees << Employee.new("2", "Sato")

# def <=>があるからsort!が処理できる
employees.sort!
employees.each do |employee|
  puts employee
end
```
`<=>`は宇宙船演算子と呼ばれ、左辺が右辺よりも小さい時`-1`、等しい場合は`0`、大きい場合は`1`を返す
個別に`<, <=, >`などの比較演算子が使いたい場合はクラスの中で`include Comparable`を記述しなければならない

### 配列演算子
**配列の積集合**
2つの配列の共通の要素を取り出して新しい配列を作る`&`
```ruby
a = [1,2,3]
b = [2.3.4]
c = a & b
puts c
#=> [2, 3]
```
**配列の和集合**
2つの配列の重複する要素を取り除いて新しい配列を作る`|`
```ruby
a = [1, 2, 3]
b = [2, 3, 4]
c = a | b
puts c
#=> [1, 2, 3, 4]
```
**配列の差集合**
左の配列から右の配列の要素を取り除いた新しい配列を作る`-`
```ruby
a = [1, 2, 3]
b = [2, 3, 4]
c = a - b
puts c
#=> 1
```

### 配列の取得
```ruby
a = [1,2,3,4]
a[0..-2].each do |i| print i, " " end
#=> 1,2,3

a[0, 3].each do |i| print i, " " end
#=> 1,2,3
```

### ヒアドキュメント
文字リテラルは`"", ''`で囲われた文字列だが`ヒアドキュメント`は`<<識別子`を含む行の次の行から`識別子`だけの行の直前までを文字列とする行指向のリテラル。
[ヒアドキュメント (行指向文字列リテラル)](https://docs.ruby-lang.org/ja/latest/doc/spec=2fliteral.html#here)

```ruby
doq = <<EOS
最近

四季の移り変わりが
曖昧で

風邪ひきやすいですよね
EOS
puts doq

#=> 最近
#=> 
#=> 四季の移り変わりが
#=> 曖昧で
#=> 
#=> 風邪ひきやすいですよね
```
慣習で`<<`のあとには`EOL(End Of Lines)`や`EOS(End Of Strings)`が使われるが何でもいい
ヒアドキュメントの識別子の前に`""`をつけると(`<<"EOS"`みたいに)、ダブルクォート文字列と同じ扱いになり、変数展開や特殊文字のエスケープが可能になる

### %演算子
`%`演算子を使って文字列にデータを埋め込むことができる。
この構文は**フォーマット文字列(sprintf関数)**と呼ばれるもので`[文字列パターン % 値]`の形式で使う。
```ruby
"数値: %d, 文字列: %s," % [10, "こんにちは"]
#=> "数値: 10, 文字列: こんにちは"
```
主なフォーマット指定子
`%d` - 整数（10進数）
`%s` - 文字列
`%f` - 浮動小数点数
`%x` - 16進数の整数
`%o` - 8進数の整数
`%p` - pメソッドの出力と同様の表現
`%%` - パーセント記号自体（%）

使用するフォーマット指定子が自主的に型を判断しているのではなく、あくまで使用される順番（左から右）に配列の要素を順番に取得している
なので以下のような場合エラーが起きる
```ruby
member = ["Ishikawa", 10]
print "ID:%2d, Name:%s" % member
#=> test.rb:286:in `%': invalid value for Integer(): "Ishikawa" (ArgumentError)
#=> print "ID:%2d, Name:%s" % member
#=>                           ^^^^^^
#=>         from test.rb:286:in `<main>'
```

### File操作
```ruby
# ファイルデータの内容
# abcdefg

File.open("data") do |io|
  while not io.eof?
    print io.read(1)
    io.seek(0, IO::SEEK_SET)
  end
end
```

`File.open("data") do |io|`: ファイル"data"（内容はabcdefg）を開く
`while not io eof?`: ファイルの終端に達していない限りループする
`print id.read(1)`: 現在のファイルポインタのいちから1文字読み取って出力する。最初のループでっはファイルポインタは先頭にあるので`"a"`を読み取る。この操作のあとポインタは1バイト目に移動する。
`io.seek(0, IO::SEEK_SET)`: ファイルポインタを先頭に戻す。
`IO::SEEK_SET`: ファイルの先頭から数える。`0`: 先頭から0バイト目という意味。
ループの先頭に戻り`is.eof?`をチェックする。
ファイルポインタは先頭に戻されているので、終端ではない。
`not io.eof?`は`true`となり、ループを継続する。
つまりこのコードは`"a"`を無限に出力し続ける。
※`eof`: End of File（ファイルの終端を示す）

### 日付フォーマット指定子
`Y`: 4桁の年（1999）
`y`: 2桁の年（99）
`M`: 月の名前(Januaryなど)
`m`: 2桁の月（01-12）
`D`: 年間通算日（001-336）
`d`: 2桁の日（01-31）

### 正規表現
**メタ文字**
- なんでもいい1文字 `.`
`私は.です` -> `私は鳥です, 私は馬です, 私は0です`
`私は...が..` -> `私はうどんが嫌い, わあつぃは早起きが苦手`
※`.`そのものを検索したいとき
`TEST\.LOG`と.の手前に`\`をつけることで`.`を正規表現の`.`ではなく単なる`"."`として検索することができる

- 行の先頭と最後 `^`, `$`
```
# 例1 今日はありがとうございました
# 例2 ありがとうといいたい
# 例3 君に心よりありがとう
```
これに対して`^ありがとう`で検索すると合致するのは例2のみ
`^`は行の先頭であることを意味する。
逆に`ありがとう$`で検索した場合、合致するのは例3のみ
また`^ありがとう$`で検索した場合、`ありがとう`の文字だけのある行に合致する。

- 同じ文字の繰り返し `+, +, ?`
```
# 正規表現
おー*い
# 検索できる文字列の例
おい　おーーい　おーーーーい
```
上記例のように`*`は`*`の直前の文字がないか、直前の文字が1個以上連絡するという意味になる
```
# 正規表現
おー+い
# 検索できる文字列の例
おーい　おーーい　おーーーーい
```
`+`の場合は`*`と違って最低でも1個は`+`の直前の文字がなければいけない。
```
# 正規表現
おー?い
# 検索できる文字列の例
おい　おーい
```
`?`の場合は、直前の文字がまったくないか、1つだけあるという意味。

- いずれかの文字列 `|`
```
# 正規表現
IBM|マイクロソフト|Apple|ネットスケープ
# 検索できる文字列
IBM, マイクロソフト, Apple, ネットスケープ
```
`|`で区切られた文字列のいずれかの文字列が存在したとき、正規表現に一致したことになる。

- 指定した文字のどれか `[]`
```
# 例１	
明日は晴です
# 例２
明日は曇です
# 例３	
明日は雨です
# 例４	
明日は雪です
```
これに対して`明日は[晴曇雪]です`の場合合致するのは例1,2,4になる
※`[]の中でメタ文字は普通の文字として認識される`

### 短絡評価
**論理演算子の特徴**
・左側から順番に評価される
・式の真偽が決定すると残りの式は評価しない
・最後に評価された式の値が論理式全体の値になる
・`false`と`nil`以外は真

`条件1 || 条件2`
この場合、条件1、条件2の順番に審議を判定する
`||`の場合、どちらかの条件の結果が真であれば結果は真になる
なので条件1が真の場合、条件2の結果を見なくても真になる

`条件1 && 条件2`
条件2は`||`とは逆に条件1の結果が真の場合のみ、評価される。

### 破壊的メソッドと定数
定数に対して破壊的メソッドを使っても警告は表示されない
```ruby
irb(main):009> STR = "hoge"
=> "hoge"
irb(main):010> STR.gsub!("hoge", "piyo")
=> "piyo"
irb(main):011> STR
=> "piyo"
```
定数に対して再代入を行うとオブジェクトIDが変わる
```ruby
irb(main):001> S = "hoge"
=> "hoge"
irb(main):002> S.object_id
=> 34560
irb(main):003> S = "piyo"
(irb):3: warning: already initialized constant S
(irb):1: warning: previous definition of S was here
=> "piyo"
irb(main):004> S.object
=> 49420
```

しかし破壊的メソッドの場合`STR`定数のオブジェクト自体は変更されていないため、警告が起きない
```ruby
irb(main):009> STR = "hoge"
=> "hoge"
irb(main):010> STR.gsub!("hoge", "piyo")
=> "piyo"
irb(main):011> STR
=> "piyo"
irb(main):012> STR.object_id
=> 261520
irb(main):013> STR.sub("piyo", "java")
=> "java"
irb(main):014> STR.object_id
=> 261520
```