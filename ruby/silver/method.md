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
```ruby
irb(main):026> b="hogepiyohogehoge"
=> "hogepiyohogehoge"
irb(main):027> b
=> "hogepiyohogehoge"

# 要素0番目から3つの要素
irb(main):028> b.slice(0,3)
=> "hog"
# 正規表現で最初に見つかった/o../を返している
irb(main):032> b.slice(/o../)
=> "oge"
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

### delete
Stringクラスのメソッド
selfから引数に含まれる文字を削除する
ただし`^`を使用すると`指定した文字以外を削除する`という意味になる
```ruby
irb(main):004> puts "0123456789-".delete("^13-56-")
13456-
=> nil
```
`1`：文字1を残す
`3-5`：文字3から5までを残す（3,4,5）
`6`：文字6を残す
`-`：文字-を残す
```ruby
irb(main):005> puts "0123456789-".delete("13-56-")
02789
```
文字列`1,3,4,5,6,-`を削除

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

### delete_if
[instance method Array#delete_if](https://docs.ruby-lang.org/ja/latest/method/Array/i/delete_if.html)
Arrayクラスのメソッド。配列に格納されている各要素に対してブロック内で処理を実行し結果が`true`の要素を取り除く
__破壊的メソッド__ 
`Arrayオブジェクト.delete_if{ |x| ... }`
```ruby
irb(main):001> a=[0,1,2,3,4,5]
=> [0, 1, 2, 3, 4, 5]
irb(main):002> a.delete_if{|n| n % 2 == 0}
=> [1, 3, 5]
irb(main):003> p a
[1, 3, 5]
```
※一致する要素が見つからない場合、常に自身を返す

### reject!メソッド
[instance method Enumerable#reject](https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/reject.html)
`delete_if`メソッドと同じ動作をするメソッドとして`reject`メソッドがある
使い方は`delete_if`メソッドと同じ
__破壊的メソッド__
```ruby
irb(main):004> b = [0,1,2,3,4,5]
=> [0, 1, 2, 3, 4, 5]
irb(main):005> b.reject!{|n| n % 2 == 0}
=> [1, 3, 5]
irb(main):006> b
=> [1, 3, 5]
```
※一致する要素が見つからない場合、`nil`を返す

### rejectメソッド
__非破壊的メソッド__
`delete_if`メソッド、`reject`メソッドの非破壊メソッド
新しい配列を返す
```ruby
irb(main):007> c = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
irb(main):008> q = c.reject{|n| n % 2 == 0}
=> [1, 3, 5]
irb(main):009> c
=> [1, 2, 3, 4, 5]
irb(main):010> q
=> [1, 3, 5]
```

### each_pair
`Struct`オブジェクトの「属性名とその値のペア」を順番に繰り返し処理するためのイテレータ
※イテレータ：データ構造の要素を順に処理する仕組み
```ruby
irb(main):004> Foo = Struct.new(:foo, :bar)
=> Foo
irb(main):005> Foo.new("Foo", "Bar").each_pair {|m, v| p [m, v] }
[:foo, "Foo"]
[:bar, "Bar"]
=> #<struct Foo foo="Foo", bar="Bar">
```

### each_index
Arrayクラスのメソッド。配列の各要素の「インデックス（添字）」のみをブロックに渡す。要素自体は渡さない。
```ruby
irb(main):047> a = ["a", "b", "c"]
=> ["a", "b", "c"]
irb(main):049* a.each_index do |index|
irb(main):050*   puts "Index: #{index}, Value: #{a[index]}"
irb(main):051> end
Index: 0, Value: a
Index: 1, Value: b
Index: 2, Value: c
=> ["a", "b", "c"]
```

### each_with_index
`each_index`と違い、「要素」と「インデックス」の療法をブロックに渡す。ブロックにわたす順番は`要素`,`インデックス`
```ruby
irb(main):052> a
=> ["a", "b", "c"]
irb(main):053* a.each_with_index do |value, index|
irb(main):054*   puts "Index: #{index}, Value:#{value}"
irb(main):055> end
Index: 0, Value:a
Index: 1, Value:b
Index: 2, Value:c
=> ["a", "b", "c"]
```

### with_index
開始インデックスを指定することができる
```ruby
irb(main):065> a
=> ["a", "b", "c"]
irb(main):066* a.each.with_index(1) do |v, i|
irb(main):067*   puts "#{i}: #{v}"
irb(main):068> end
1: a
2: b
3: c
=> ["a", "b", "c"]
```

### shift
配列に対するメソッド。配列の先頭の要素を取り出して返す。
__破壊的メソッド__
```ruby
irb(main):075> a
=> ["a", "b", "c"]
irb(main):076> a.shift
=> "a"
irb(main):077> a
=> ["b", "c"]
irb(main):079> q = a.shift
=> "b"
irb(main):080> q
=> "b"
irb(main):081> a
=> ["c"]
```
`shift`に引数を加えると先頭からその要素分を取り出して返す
```ruby
irb(main):082> a = ["a", "b", "c"]
=> ["a", "b", "c"]
irb(main):083> b = a.shift(2)
=> ["a", "b"]
irb(main):084> a
=> ["c"]
irb(main):085> b
=> ["a", "b"]
```

### unshift
配列の先頭に引数を要素として追加する
```ruby
irb(main):092> a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
irb(main):093> a.unshift(0)
=> [0, 1, 2, 3, 4, 5]
irb(main):094> a.unshift(0,2)
=> [0, 2, 0, 1, 2, 3, 4, 5]
irb(main):095> a.unshift("a")
=> ["a", 0, 2, 0, 1, 2, 3, 4, 5]
```

### pop
配列の最後の要素を削除する

### push
配列の最後に要素を追加する

### compact
自身から`nil`を除いた配列を生成して返す
__非破壊メソッド__
```ruby
irb(main):015> ary = [1, nil, 2, nil, 3, nil]
=> [1, nil, 2, nil, 3, nil]
irb(main):016> ary.compact
=> [1, 2, 3]
irb(main):017> ary
=> [1, nil, 2, nil, 3, nil]
```
破壊的メソッドの`compact!`もある
```ruby
irb(main):018> ary
=> [1, nil, 2, nil, 3, nil]
irb(main):019> ary.compact!
=> [1, 2, 3]
irb(main):020> ary
=> [1, 2, 3]
```
※`nil`が含まれない配列に`compact!`を使うと`nil`が返ってくる
```ruby
irb(main):021> [1,2,3].compact!
=> nil
```

### uniq
配列から重複を除いた配列を返す
__非破壊メソッド__
```ruby
irb(main):022> a = [1,1,1].uniq
=> [1]
irb(main):023> [1,4,1].uniq
=> [1, 4]
irb(main):024> [1, 3, 2, 2, 3].uniq
=> [1, 3, 2]
```
破壊的メソッドの`uniq!`も存在する
```ruby
irb(main):025> a = [1,1,1]
=> [1, 1, 1]
irb(main):026> a.uniq!
=> [1]
irb(main):027> a
=> [1]
irb(main):028> b = [1,4,1]
=> [1, 4, 1]
irb(main):029> b.uniq!
=> [1, 4]
irb(main):030> b
=> [1, 4]
```

### find, detect
要素に対してブロックを評価した値が真になった最初の要素を返す
```ruby
irb(main):042> a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
irb(main):043> a.find {|n| n > 3}
=> 4
```

### select, find_all
Arrayクラスのメソッド。各要素に対してブロック評価した値が真である要素を含む全ての配列を返す。
真になる要素がなにもなかった場合、空の配列を返す。
```ruby
irb(main):045> a
=> [1, 2, 3, 4, 5]
irb(main):046> a.select{|n| n.odd?}
=> [1, 3, 5]
irb(main):047> a.select{|n| n.even?}
=> [2, 4]
irb(main):048> a.select{|n| n % 6 == 0}
=> []
```

### map, collect
ブロックの戻り値を集めた新しい配列を返す
```ruby
irb(main):049> a
=> [1, 2, 3, 4, 5]
irb(main):050> a.map {|n| n * 2}
=> [2, 4, 6, 8, 10]
irb(main):051> a
=> [1, 2, 3, 4, 5]
irb(main):052> a.collect {|n| n * 2}
=> [2, 4, 6, 8, 10]
```

### inject
配列やハッシュなどの要素を順番に処理して集計するためのメソッド
引数が初期値（下のコードの`result`）になる
```ruby
irb(main):059> array = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
irb(main):060> sum = array.inject(0) {|result, item| result + item}
=> 15
```
上記コードの処理の流れは以下の通り
```shell
1. result = 0, item = 1 -> result + item = 0 + 1 = 1
2. result = 1, item = 2 -> result + item = 1 + 2 = 3
3. result = 3, item = 3 -> result + item = 3 + 3 = 6
4. result = 6, item = 4 -> result + item = 6 * 4 = 10
5. result = 10, item = 5 -> result + item = 10 + 5 = 15
```
引数を入れない場合は配列の最初の要素が初期値になる
```ruby
irb(main):076> a = ["a", "b", "c", "d", "e"]
=> ["a", "b", "c", "d", "e"]
irb(main):077> a.inject { |result, item| result+item }
=> "abcde"
irb(main):078> a.inject("www") {|result, item| result+item}
=> "wwwabcde"
```
初期値がある場合とない場合で処理が異なる

- 初期値がある場合
最初のresultに初期値が入る
配列のすべての要素に対して処理が行われる
処理回数 = 配列の要素数
```ruby
# 初期値あり：resultの初期値は""
# 処理回数は5回（配列の全要素）
irb(main):088> a.inject("") {|result, item| result + item}
=> "abcde"
```
- 初期値がない場合
最初のresultに配列の最初の要素が入る
配列の2番目以降の要素に対して処理が行われる
処理回数 = 配列の要素数 - 1
```ruby
# 初期値なし：resultの初期値は"a"
# 処理回数は4回（"b"から"e"）
irb(main):089> a.inject {|result, item| result + item}
=> "abcde"
```

### transpose
自身を行列と見立てて、行列の転置（行と列の入れ替え）を行う
```ruby
irb(main):011> a = [1,2,3]
=> [1, 2, 3]
irb(main):012> b = ["a", "b", "c"]
=> ["a", "b", "c"]
irb(main):013> [a, b].transpose
=> [[1, "a"], [2, "b"], [3, "c"]]
irb(main):014> [a, b].transpose.each{|s, v| p [s,v]}
[1, "a"]
[2, "b"]
[3, "c"]
=> [[1, "a"], [2, "b"], [3, "c"]]
irb(main):015> [a, b].transpose{|s, v| p [s,v]}
=> [[1, "a"], [2, "b"], [3, "c"]]
```

### index
Stringクラスのメソッド
文字列のインデックスから右に向かって引数を検索し、最初に見つかった部分文字列の左端のインデックスを返す
見つからなければnilを返す
引数は探索する部分、文字列または正規表現で指定する
[instance method String#index](https://docs.ruby-lang.org/ja/latest/method/String/i/index.html)
`"文字列".index(検索パターン [, 開始位置])`
```ruby
irb(main):025> str = "RubySilver Testing"
=> "RubySilver Testing"
irb(main):026> str.index("Silver")
=> 4

irb(main):028> s="Ruby SilverS".index("S", 6)
=> 11
irb(main):029> s="Ruby SilverS".index("S", 3)
=> 5
```

```
/^[0-9].$/
/^[0-9]*$/
/^[0-9][0-9]*$/
/^[0-9][0-9].$/
```

### scan
Stringクラスのメソッド。引数で指定した正規表現のパターンからマッチした文字列を取得し、配列として返す
```ruby
irb(main):009> "abc def 123 ghi 456".scan(/\d+/)
=> ["123", "456"]
irb(main):010> "abc def 123 ghi 456".scan(/\d+/).length
=> 2

irb(main):012> "abc def 123 ghi 456".scan(/\d*/)
=> ["", "", "", "", "", "", "", "", "123", "", "", "", "", "", "456", ""]
irb(main):015> "abc def 123 ghi 456".scan(/\d*/).length
=> 16
```

### chr
selfの最初の文字だけのを含む文字列を返す
```ruby
irb(main):021> "abc".chr
=> "a"
```

### ord
文字列の最初の文字の文字コードを整数で返す
```ruby
irb(main):023> "A".ord
=> 65
irb(main):024> "ABC".ord
=> 65
```

### merge
Hashクラスのメソッド。selfとotherのハッシュの内容を順番にマージした結果を返す。
```ruby
irb(main):051> h1 = {"a" => 100, "b" => 200}
=> {"a"=>100, "b"=>200}
irb(main):052> h2 = {"b" => 246, "c" => 300}
=> {"b"=>246, "c"=>300}
irb(main):053> h3 = {"b" => 357, "d" => 400}
=> {"b"=>357, "d"=>400}
irb(main):054> h1.merge(h2)
=> {"a"=>100, "b"=>246, "c"=>300}
irb(main):055> h1
=> {"a"=>100, "b"=>200}
irb(main):056> h1.merge(h2, h3)
=> {"a"=>100, "b"=>357, "c"=>300, "d"=>400}
irb(main):057> h1
=> {"a"=>100, "b"=>200}

irb(main):058> foo = {1 => "a", 2 => "b", 3 => "c"}
=> {1=>"a", 2=>"b", 3=>"c"}
irb(main):059> bar = {2 => "B", 3 => "C", 4 => "D"}
=> {2=>"B", 3=>"C", 4=>"D"}
irb(main):060> foo.merge(bar)
=> {1=>"a", 2=>"B", 3=>"C", 4=>"D"}
```

### update
`merge`メソッドの破壊的メソッドエイリアス

### open
ファイルを開くためのメソッド。
第一引数にファイル名（ファイルのある場所）を指定
第二引数にファイルオプションを指定
`file = File.open(hoge.txt, "w")`
`hoge.txt`:ファイル名
`w`:書き込み
ファイルオプションには
`r(read)`:読み込む（デフォルト０
`w(write)`:書き込む（指定したファイルが存在する場合、すべて上書きする。もともとのデータは消える）
`a(append)`:元々あるデータの末尾から付け加える
上記3つが存在する。
3つのあとに`+`をつけるとファイルは読み書き両用で開く。

### File.join
複数の文字列を結合してパス文字列を作成する。
引数に含まれるパス区切り文字の重複を自動的に解消する。

### File.expand_pass
相対パスを絶対パスに変換

### File.dirname
ファイルパスからディレクトリ部分を取得

### File.basename
ファイルパスからファイル名部分を取得

### File.extname
ファイル名から拡張子を取得
