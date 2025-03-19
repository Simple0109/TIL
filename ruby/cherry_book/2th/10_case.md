## case文
1つのオブジェクトや四季を複数の値と比較する場合は`elsif`を重ねるよりも`case`文で書いたほうがシンプルになる
```ruby
# if文の場合
country = "italy"

if country == "jp"
  "こんにちは"
elsif country == "us"
  "Hello"
elsif country == "italy"
  "Ciao"
else
  "???"
end

# case文の場合
case country
when "jp"
  "こんにちは"
when "us"
  "Hello"
when "italy"
  "Ciao"
else
  "???"
end
```

if文同様最後に評価された値を戻り値として返すため、case文の結果を変数にいれることができる
```ruby
country = "jp"

message = 
case country
when "jp"
  "こんにちは"
when "us"
  "Hello"
when "italy"
  "Ciao"
else
  "???"
end

message
```

### 三項演算子
`式 ? 真だった場合 : 偽だった場合`
という三項演算子を使うことができる
``` ruby
n = 11
if n > 10
  "10より大きい"
else
  "10より小さい"
end

# 上記コードは以下のように書き直すことができる
n = 11
message = n > 10 ? "10より大きい" : "10より小さい"
message
```