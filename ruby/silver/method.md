### zipメソッド
Arrayクラスで使えるメソッド
[instance method Array#zip](https://docs.ruby-lang.org/ja/latest/method/Array/i/zip.html)
自身と引数に渡した配列の各要素からなる配列の配列を生成して返す
生成される配列の要素数は self の要素数と同じ
```ruby
a = [1,2,3]
b = [4,5,6]
c = [7,8,9]
p a.zip(b, c)
#=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

a = [1,2,3]
b = [4,:a,:v]
c = [7,8,9]
p a.zip(b, c)
#=> [[1, 4, 7], [2, :a, 8], [3, :v, 9]]

# 生成される配列の要素数は元の配列と同じ
a = [1,2,3]
b = [4,5,6,7]
c = [8,9,10,11,12]
p a.zip(b, c)
#=> [[1, 4, 8], [2, 5, 9], [3, 6, 10]]

# 途中返すものがない場合、nilを返す
a = [1,2,3]
b = [4,7]
c = [8,9,10,11,12]
p a.zip(b, c)
#=> [[1, 4, 8], [2, 7, 9], [3, nil, 10]]
```

### sliceメソッド
Arrayクラスのメソッド。要素のインデックスを整数で指定することができる
[instance method Array#slice](https://docs.ruby-lang.org/ja/latest/method/Array/i/slice.html)
```ruby
a=[1,2,3,4,5]
p a.slice(0) #=> 1

# 第二引数で取得した要素のインデックスを含めた要素数を指定
p a.slice(0, 2) #=> [1,2]

# 範囲を指定するとそのインデックス要素すべて取得
p a.slice(0..3) #=> [1,2,3,4]

# 配列の要素数を超えるとき、すべてを取得。エラーは起きない。
p a.slice(0, 10)  #=> [1,2,3,4,5]

# 第一引数で存在しないインデックスを指定したとき、nilが変える
p a.slice(10, 1) #=> nil
```

### chopメソッド
文字列の最後の文字を取り除いた新しい文字列を生成して返す。
ただし文字列の終端が`"\r\n`であればその2文字を取り除く
```shell
irb(main):009> "hogehoge".chop
=> "hogehog"

irb(main):010> "hogehoge\n".chop
=> "hogehoge"

irb(main):011> "hogehoge\r\n".chop
=> "hogehoge"

irb(main):012> "".chop
=> ""
```
`chop`メソッドは破壊的ではなく破壊的にしたい場合`chop!`メソッドを使う

### chompメソッド
Stringクラスのメソッド。末尾から改行コードを取り除いた文字列を生成して返す。
[instance method String#chomp](https://docs.ruby-lang.org/ja/latest/method/String/i/chomp.html)
```shell
irb(main):014> "hogehoge\n".chomp
=> "hogehoge"

irb(main):015> "hogehoge\r\n".chomp
=> "hogehoge"

irb(main):016> "".chomp
=> ""

irb(main):017> "hogehoge".chomp
=> "hogehoge"
```
`chomp`メソッドは破壊的ではなく破壊的にしたい場合`chomp!`メソッドを使う

### invertメソッド
Hashクラスのメソッド。値からキーへハッシュを作成して返す。
[instance method Hash#invert](https://docs.ruby-lang.org/ja/latest/method/Hash/i/invert.html)
```ruby
h = {"a": 0, "b": 1, "c": 2, "d": 3,}
p h.invert
#=> {0=>:a, 1=>:b, 2=>:c, 3=>:d}
```

### has_key?(key)
Hashクラスのメソッド。ハッシュが指定したキーを持つかどうかboolを返す
```ruby
h = {"a": 0, "b": 1, "c": 2, "d": 3}
# キーが自動的にシンボルになるため:bを指定
p h.has_key?(:b)
#=> true

p h.has_key?(:q)
#=> false

# キーを文字列にしたい場合は以下のように記述する
h = {"a" => 0, "b" => 1, "c" => 2}
p h.has_key?("a")
#=> true
```
`has_key?`と同じ意味、同じ機能のメソッドは以下の通り
- `has_key?`
- `key?`
- `include?`
- `member?`

### delete
Hashクラスのメソッド。キーに対応する要素を除く。
```shell
irb(main):028> h
=> {:a=>0, :b=>1, :c=>2}
irb(main):029> h.delete(:a)
=> 0
irb(main):030> h
=> {:b=>1, :c=>2}
```

### fetch
Hashクラスのメソッド。キーに対応する値を返す。
```shell
irb(main):031> h = {"a": 0, "b": 1, "c": 2}
=> {:a=>0, :b=>1, :c=>2}
irb(main):032> h.fetch(:a)
=> 0
irb(main):033> h.fetch(:b)
=> 1
irb(main):034> h.fetch(:c)
=> 2
```

### clear
Hashクラスのメソッド。ハッシュの中を空にする。
```shell
irb(main):035> h
=> {:a=>0, :b=>1, :c=>2}
irb(main):036> h.clear
=> {}
```

### Time
時刻を表すクラス。
```shell
irb(main):056> Time.now
=> 2025-03-26 14:58:08.013867 +0900
irb(main):052> Time.gm(1999,1,1)
=> 1999-01-01 00:00:00 UTC
```

### sub
`文字列.sub(/正規表現/, "変換後の文字")`
というふうに使用する。
```ruby
irb(main):003> str = "ruby ruby ruby"
=> "ruby ruby ruby"
irb(main):004> str.sub(/ruby/, "java")
=> "java ruby ruby"
```
上記のようにマッチした最初の要素が変更される（非破壊）
破壊的メソッドの`sub!`メソッドもある

### gsub
`gsub`メソッドは`sub`メソッドのようにマッチした最初の要素のみではなく、正規表現にマッチした部分をすべて変換する
```ruby
irb(main):007> str = "ruby ruby ruby"
=> "ruby ruby ruby"
irb(main):008> str.gsub(/ruby/, "java")
=> "java java java"
```
これも破壊的メソッドの`gsub!`メソッドが存在する

### to_iメソッド
文字列を整数に変換する
1. 文字列の先頭から順番に数字を読み取る
2. 数字ではない文字に遭遇した時点で変換を終了する
3. 先頭が数字ではない場合`0`を返す
```ruby
irb(main):010> "123ab".to_i
=> 123
irb(main):011> "ab123".to_i
=> 0
irb(main):012> nil.to_i
=> 0
irb(main):013> Integer("123")
=> 123
irb(main):014> Integer("123ab")
(irb):14:in `Integer': invalid value for Integer(): "123ab" (ArgumentError)
```

### splitメソッド
文字列を任意の条件で分割し、配列に格納する
`"文字列".split(区切り文字, 分割数)`
```ruby
# 指定した文字列で分割
irb(main):029> "apple,banana,orange".split(",")
=> ["apple", "banana", "orange"]
```

区切り文字に正規表現を使うこともできる
```ruby
# 正規表現を使う場合//で囲む
irb(main):030> "apple,banana,orange".split(/,/)
=> ["apple", "banana", "orange"]

# 複数条件で区切りたいときは|を使う
irb(main):032> "apple,banana;orange+cherry".split(/,|;|\+/)
=> ["apple", "banana", "orange", "cherry"]
```

区切り文字に`" "（空白文字）`を指定すると「文字列の先頭と末尾の空白文字」を除き、なおかつ空白文字で分割してくれる
```ruby
irb(main):034> "       apple banana  orange cherry   ".split(" ")
=> ["apple", "banana", "orange", "cherry"]
# nilを入れても同じ結果が得られる
irb(main):035> "       apple banana  orange cherry   ".split(nil)
=> ["apple", "banana", "orange", "cherry"]
# なにも指定しなくても同じ結果が得られる
irb(main):036> "       apple banana  orange cherry   ".split
=> ["apple", "banana", "orange", "cherry"]
```