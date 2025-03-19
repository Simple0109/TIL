### 真偽値
Rubyでは
・`false`または`nil`であれば偽
・それ以外は真
というルールがある。

```ruby
# 以下すべて真
1
2
0

"true"
"false"
""
```

### if文
```ruby
n = 11
if n > 10
  puts "10より大きい"
else
  puts "10以下"
end
#=> 10より大きい
```
```ruby
country = "italy"
if country == "japan"
  puts "こんにちは"
elsif country == "us"
  puts "Hello"
elsif country == "italy"
  puts "Ciao"
else
  puts "???"
end
#=> "Ciao" 
```
以下のようにif文の戻り値を変数に代入することもできる
```ruby
country = "italy"

greeting =
  if country == "japan"
    "こんにちは"
  elsif country == "italy"
    "Ciao"
  else
    "???"
  end

greeting
#=> "Ciao"
```
※仮にどの条件にも一致しなかった場合はnilがかえる

### 後置if
if文は装飾子として後ろに置くことができる
```ruby
point = 7
day = 1

point *= 5 if day == 1
point
#=> 35
```

ifとelsifの後ろに`then`をおいて真偽の場合の処理を1行に押し込めることもできる。が使用頻度は高くない。
```ruby
country = "italy"
if country == "us" then "hello"
elsif country == "japan" then "こんにちは"
elsif country == "italy" then "Ciao"
end
```