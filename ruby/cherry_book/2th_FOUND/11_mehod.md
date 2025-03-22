### デフォルト値のある引数
Rubyではメソッドを呼び出すとき引数に過不足があるとエラーが起きる
```ruby
def greet(country)
  if country == "japan"
    "こんにちは"
  else
    "Hello"
  end
end

# 引数が少ない
greet
#=> (irb):1:in `greet': wrong number of arguments (given 0, expected 1) (ArgumentError)

# ok
greet("japan")
#=> こんにちは

# 引数が多い
greet("japan", "us")
#=> (irb):1:in `greet': wrong number of arguments (given 2, expected 1) (ArgumentError)
```

このメソッドで引数デフォルト値を入れることができる
```ruby
def greet(country = "japan")
  if (country == "japan")
    "こんにちは"
  else
    "Hello"
  end
end

greet #=> こんにちは
greet("us") #=> Hello
```

デフォルト値ありと、デフォルト値なしの引数を混在させることもできる
```ruby
def default_args(a, b, c = 0, d = 0)
  "a=#{a}, b=#{b}, c=#{c}, d=#{d}"
end

#default_args(1,2) #=> "a=1, b=2, c=0, d=0"
default_args(1,2,3) #=> "a=1, b=2, c=3, d=0"
#default_args(1,2,3,4) #=> "a=1, b=2, c=3, d=4"
```

デフォルト値は固定の値ではなく動的に変わる値や他のメソッドの戻り値を指定することもできる
```ruby
def foo(time = Time.now, message = bar)
  "time: #{time}, message: #{message}"
end

def bar
  "Bar"
end

foo
```

デフォルト値には左にある引数を使うこともできる
```ruby
def point(x, y =x)
  "x=#{x}, y=#{y}"
end

point(3)
```

### ?で終わるメソッド
`?`で終わるメソッドは慣習として真偽値を返すメソッドになっている
このようなメソッドを`述語メソッド`と呼ぶ
```ruby
# 空文字ならtrue, そうでなければfalse
"".empty? #=> true
"abc".empty? #=> false

# 引数も文字列が含まれていればtrue, そうでなければfalse
"watch".include?("at") #=> true
"watch".include?("in") #=> false

# 奇数ならtrue, 偶数ならfalse
1.odd? #=> true
2.odd? #=> false

# 偶数ならtrue, 奇数ならfalse
1.even? #=> false
2.even? #=> true

# オブジェクトがnilならtrue, そうでなければfalse
nil.nil? #=> true
"abc".nil? #=> false
2.nil? #=> false
```

### !で終わるメソッド
`!`で終わるメソッドは`!`がついていないメソッドよりも危険ということを意味する。
```ruby
a = "ruby"

# upcaseだとaの値は変化しない
a.upcase #=> RUBY
a #=> ruby 

# upcase!だとaの値も大文字になる
a.upcase! #=> RUBY
a #=> RUBY
```
このように呼び出し元のオブジェクトの状態を変更`破壊的メソッド`と呼ぶ。
※
`!`がついているからといってすべてのメソッドが破壊的メソッドなわけではない。
`upcase`のように同じ動作で非破壊的なメソッドと破壊的メソッドが定義されているときは破壊的なメソッドに`!`がついている。
`!`がついているメソッドが破壊的というのは常に成立するが、必ずしも逆は成立しないことに注意。

### エンドレスメソッド（1行メソッド定義）
Ruby3.0では`end`を省略して1行でメソッドを定義できる`エンドレスメソッド構文`が導入された
```ruby
# 以下は同じ処理が行われる
def greet
  "Hello"
end
greet #=> "Hello"

def greet = "Hello"
greet #=> "Hello"

def add(a, b)
  a + b
end
add(1,2) #=> 3

def add(a, b) = a + b
add(1, 2) #=> 3
```
※
Ruby3.0の時点では実験的機能という位置づけになっており、Ruby3.1以降で仕様が変わる可能性があるので、業務で使用する場合は使用が確定してからにすること。