### アンスコで変数名を始めてもいい

```ruby
// 特に問題なし。ただし使うことは稀
_hoge = "hoge"
```

しかし「宣言するが、使われない」という意味を持たせるためにあえてアンスコで始まる変数名を使うことがある

```ruby
first_name, _last_name = "ishikawa sosososo".split(" ")
puts first_name #=> "ishikawa"

first_name, _ = "ishikawa sosososo".split(" ")
puts first_name #=> "ishikawa"
```

Go 書いているとき`err, _`みたいな書き方した気がする

### =を複数回使って２個以上の変数に同じ値を入れることもできる（があまり推奨されなそうだし、個人的に気持ち悪い）

```ruby
a = b = 100
puts a #=> 100
puts b #=> 100
```

とすることができる。
が例えば変数に小文字の文字列を入れて、大文字に変換する`upcase`を使ったとき予期せぬ挙動を引き起こすので、やめておこう

```ruby
a = b = "hello"
a.upcase!
puts a #=> "HELLO"
# bも大文字になっちゃう
puts b #=> "HELLO"
```

### 文字列の比較

文字列が同じ値か調べるには`==`, 異なる値か調べるときは`!=`を使う

```ruby
"ruby" == "ruby" #=> true
"ruby" == "dart" #=> false
"ruby" != "dart" #=> true
"ruby" != "ruby" #=> false
```

文字列を不等号で比較できることを知らなかった。この場合文字列を構成するバイト数で大小の比較を行う

```ruby
"a" < "b" #=> true
"a" < "A" #=> false
```

```shell
irb(main):018> "a".bytes
=> [97]
irb(main):019> "A".bytes
=> [65]
```

知らなかった
