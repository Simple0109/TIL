## 例外処理
例外 -> プログラム実行中のエラー
rubyで例外を補足するためのメソッドは`rescue`
`rescue`メソッドを使えば例外が発生したときの処理をあらかじめ設定することできる
なぜ上記のような例外処理が必要か？
->例外処理を書いておかないと例外が発生したときプログラムが停止してしまう->*それ以降に記述しているコードが読み込まれない*
Rubyには様々な例外が設定されている。一例として
- 0で助産したときの`ZeroDivisionError`
- メモリ確保に失敗したときの`NomMemoryError`
- 予想されていた引数の数よりも少ないときに発生する`ArgumentError`
- 定義されていないローカル変数や定数を使用したときに発生する`NameError`
その他は以下リンク参照[例外クラス](https://docs.ruby-lang.org/ja/latest/class/Exception.html)

### 基本的な`rescue`の使い方
```ruby
begin
  1/0
rescue
  puts "0で割ってはだめです!"
end
#=> 0で割ってはだめです!
```
このプログラムでは`1/0`部分で整数は0で割れないことから`ZeroDivisionError`の例外が発生する
beginブロックで例外が発生するとbeginブロックの処理は*中断*され、処理の`rescue`ブロックに移る
その後beginブロックに復帰せずにendまで処理が進んでいる

### 例外の補足
`rescue`では具体的にどのようなエラーがでたのか補足することができる
```ruby
begin
  1/0
  rescue => e
    puts e
end
#=> divided by 0
```
この場合どの例外を処理するかは省略されているが、厳密には`StandardError`クラスのサブクラスにあたる例外のみを補足している
`ZeroDivisionError`クラスは`StandardError`クラスを継承しているので、この場合例外を補足することができる

上記コードを省略しないで書くと以下のようになる
```ruby
begin
  1/0
rescue => StandardError => e
  puts e
end
#=> divided by 0
```
`e`には例外オブジェクトが代入される。例外オブジェクトに実装されているメソッドを使用することができる
```ruby
begin
  1/0
  rescue StandardError => e
    puts e
    puts e.class
    puts e.class.superclass
    puts e.message
end
#=> divided by 0
#=> ZeroDivisionError
#=> StandardError
#=> divided by 0
```

### 例外の種類を分ける
エラーの種類に応じて例外処理を分けることが可能
```ruby
begin
  1/0
rescue ZeroDivisionError => e
  puts e.class
  puts e.message
end
#=> ZeroDivisionError
#=> divided by 0
```
このコードの場合`ZeroDivisionError`が発生したときの例外処理を記述しており、それ以外の例外は補足しない。

また例外には複数引数を渡すことができる
```ruby
def fullname(surname, firstname)
  "#{surname} #{firstname}"
end

begin
  1/3
  puts fullname("石川")
rescue ArgumentError, ZeroDivisionError => e
    puts e.class
    puts e.message
end
#=> ArgumentError
#=> wrong number of arguments (given 1, expected 2)
```

### 例外の有無に関わらず実行する`ensure`
`ensure`メソッドは例外の有無にかかわらず実行される
```ruby
begin
  1/0
rescue => e
  puts e
ensure
  puts "ensure"
end
#=> divided by 0
#=> ensure

# 例外が発生しない場合もensureブロックが実行される
begin
  1/1
rescue => e
  puts e
ensure
  puts "ensure"
end
#=> ensure
```

### 処理をもう一度やり直す`retry`
`retry`メソッドはbeginからの実行をもう一度やり直す
```ruby
count = 0
begin
  1/0
rescue
  p count += 1
  retry if count < 5
  puts "無理でした"
end
#=> 1
#=> 2
#=> 3
#=> 4
#=> 5
#=> 無理でした
```
`count`が5未満のときはbeginブロックの処理に戻る
`count`が5を超えたとき`retry`が実行されず`"無理でした"`が表示される

### 意図的に例外を発生させる`raise`
`raise`メソッドは意図的に例外を起こすためのメソッド
以下のように強制的に例外を引き起こすことができる
```ruby
begin
  raise
  rescue
    p "例外です"
end
#=> 例外です
```
以下のように引き起こす例外の種類を指定することもできる
```ruby
begin
  raise ZeroDivisionError
rescue => e
  p e.class
end
#=> ZeroDivisionError
```

