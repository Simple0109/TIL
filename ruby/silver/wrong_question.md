### オーバーライドが不可能な演算子
```
?:（三項演算子）
=（代入）
&&, ||, and, or, not（論理）
defined?（定義） 
.., ...（範囲）
```

### 標準ライブラリ
Rubyのコアには含まれていないが、Rubyといっしょにインストールされる標準ライブラリは`require`が必要！
```ruby
require "json"
require "net/http"
require "csv"
require "data"
require "time"
```

### 組み込みクラスやモジュール
Rubyの基本的な機能（組み込みライブラリ）は自動的に利用可能
`require`必要なし！
```ruby
String
Array
Hash
Integer
Float
Kernel
Enumerable
```

### sliceメソッド
配列や文字列などから指定した要素を抽出するメソッド
- 指定したインデックスの要素を抽出：`slice(index)`
```ruby
irb(main):027> arr = ["Ruby", "PHP", "Python", "Java"]
=> ["Ruby", "PHP", "Python", "Java"]
irb(main):028> arr.slice(1)
=> "PHP"
irb(main):029> arr.slice(0)
=> "Ruby"
```
- インデックスとそこからの長さを指定して要素を抽出：`slice(index, length)`
```ruby
irb(main):030> arr
=> ["Ruby", "PHP", "Python", "Java"]
irb(main):031> arr.slice(0, 2)
=> ["Ruby", "PHP"]
irb(main):032> arr.slice(2, 2)
=> ["Python", "Java"]
```
- 範囲を指定して要素を抽出：`slice(range)`
```ruby
irb(main):033> arr
=> ["Ruby", "PHP", "Python", "Java"]
irb(main):034> arr.slice(0..2)
=> ["Ruby", "PHP", "Python"]
irb(main):035> arr.slice(2..3)
=> ["Python", "Java"]
irb(main):036> arr.slice(3..10)
=> ["Java"]
```
- 文字列の場合は、正規表現に一致する文字を抽出：`slice(regex)`
```ruby
irb(main):062> str
=> "1234567890ABCDEFG"
irb(main):062> str.slice(/[A-Z]+/)
=> "ABCDEFG"
irb(main):063> str.slice(/[0-9]+/)
=> "1234567890"
```

### 文字列の比較
**`eql?`**
同値性の比較。
オブジェクトの値を型も含めて同じかどうか比較している
```ruby
# 同じ値の場合true
irb(main):078> a = "hello"
=> "hello"
irb(main):079> b = "hello"
=> "hello"
irb(main):080> a.eql? b
=> true

# ==は型のチェックを行っておらず、値のみで判断
irb(main):081> a = 1
=> 1
irb(main):082> b = 1.0
=> 1.0
irb(main):083> a.eql? b
=> false
irb(main):084> a == b
=> true
```


**`equal?`**
`object_id`が等しいか比較している
```ruby
irb(main):090> a = "hoge"
=> "hoge"
irb(main):091> b = "hoge"
=> "hoge"
irb(main):092> a.equal? b
=> false
irb(main):093> a.object_id
=> 1122600
irb(main):094> b.object_id
=> 1130360
```

**`===`**
左辺が右辺を含むか判定している
```ruby
irb(main):095> puts (1..10) === 5
true
=> nil
irb(main):096> (1..10) === 5
=> true
irb(main):097> Integer === 5
=> true
irb(main):098> Integer === Array
=> false
irb(main):100> /\d+/ === "123"
=> true
```

```ruby
s = <<"EOB"
Hello,
Ruby
World.
EOB
"EOB"

p s
```
