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

## &&や||の戻り値と評価を終了するタイミング
```ruby
1 && 2 && 3 #=> 3
1 && nil && 3 #=> nil
1 && false && 3 #=> false

nil || false #=> false
false || nil #=> nil
nill || false || 2 || 3 #=> 2
```
Rubyでは式全体が真または偽であることが決定するまで左から順番に式を評価する。
式全体の真または偽が確定すると、式の評価を終了して、最後に評価した式の値を返す。

## unless文
if文と反対の意味をもつのが`unless`文
条件式が偽の場合のみ処理を実行する。if文で否定の条件を書いているとき、`unless`文に書き換えられる
```ruby
status = "error"
if status != "ok"
  "なにか異常があります"
end
#=> なにか異常があります

# 上記コーデゃunlessで書き換えられる
status = "error"
unless status == "ok"
  "なにか異常があります"
end
#=> なにか異常があります
```
elseを使って条件が偽でなかった場合（真だった場合）の処理を書くこともできる
```ruby
status = "error"
unless status == "ok"
  "なにか異常があります"
else
  "正常です"
end
```
※ただし`elsif`に相当するものはunlessにはない
if文と同じく後置することもできる
```ruby
status = "error"
"なにか異常があります" unless status == "ok"
```