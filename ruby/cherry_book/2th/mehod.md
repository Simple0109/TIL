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