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