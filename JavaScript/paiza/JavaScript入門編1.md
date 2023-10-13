### 出力
文字列の表示は`console.log("");`と入力する(ダブルクォーテーションに文字列を入力)
※数値の場合は`""`は必要ない(`console.log(100);`みたいな感じ)
このconsole.logのような命令を**関数**と呼ぶ

### コメントアウト
JavaScriptでコメントアウトするときは`//`をコメントの前につける
ただし`console.log("hello //world");`を出力すると`//`は文字列化され`hello //world`と表示される
`//console.log("hello //world");`と入力されるとこのコードは出力されなくなる
複数行をコメントアウトしたい場合、先頭行の頭に`/*`最終行の最後に`*/`をつけると複数行コメントアウトすることができる
```
console.log("hello workd1");
/*console.log("hello workd2");
console.log("hello workd3");*/
//このように書くと`hello world1`のみが出力される
```

### HTMLの出力
`console.log("<h1>hello world</h1>");`とh1タグで囲むことでHTMLを表示することができる
```
console.log("<h1>hello world</h1>");
console.log("<p>世界の皆さん、 ");
console.log("<b>こんにちは</b></p>");
```
と記述した場合

hello world
世界の皆さん、 **こんにちは**

と表示される。h1タグは閉じた段階で改行されるが、それ以外のタグはbrタグがないと改行されない

JavaScriptのテキスト表示（HTMLではない）で改行したくない場合は、`console.log("");`ではなく、`process.stdout.write("")`と記述する
この関数(process.stdout.write)をプロセススタンダードアウトライト関数と呼ぶ
なお、JavaScriptの表示は改行されないが、HTMLタグで改行されている場合はHTML表示では改行される
プロセススタンダードライトアウト関数を使用してテキストコードを改行したい場合
```
process.stdout.write("<h1>hello world</h1>\n");
process.stdout.write("<p>世界の皆さん.\n");
process.stdout.write("<b>こんにちは</b></p>\n");
```
のように`\n`を末尾のダブルクォーテーションの前に入力する

### 変数
変数を使用したい場合`var 変数名 = "内容";`のように記述する(例:`var player = "勇者";`)
代入された変数を出力したい場合
```
var player = "勇者";
console.log(player);
```
を実装すると`勇者`が出力される
変数と文字列を同時に出力したい場合`console.log(player + "は、荒野を歩いていた");`のように記述する

### サイコロを作る
ランダムな数値を使用したいときは`random関数`を使う
```
var randnum = Math.random();
console.log(randnum);
```
とすることで0~1の間の数値をランダムに返す
ランダムな数値を指定するには以下のようにする。今回は1~10の数値を得たいとする
```
var randnum = Math.random() * 10;
console.log(randnum);
```
とすること0~1の間の数値が10倍される。しかしこのままだと小数点が表示されてしまうので、小数点以下の数値を切り捨てる`paerseInt関数`を使う。
```
var randnum = parseInt(Math.random() * 10);
console.log(randnum);
```
とすることで小数点以下の数値が切り捨てられる。しかしこのままでは0~10未満の数値がランダムに表示されてしまう。よって以下のように修正する。
```
var randnum = parseInt(Math.random() * 10) + 1;
console.log(randnum);
```
とすることで1~10の数値を得ることができる

### 演算子で計算してみよう
変数同士を`+,-,*,/,%`の演算子を組み合わせて計算することができる
```
var number = 100;
console.log(number + number);
console.log(number + 10);
```
とすると200と110が得られる
使用できる演算子はrubyと同じ
計算の優先順位は`*,/>+,-`となる

### データの型を覚えよう
