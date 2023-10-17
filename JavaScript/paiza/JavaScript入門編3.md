## while文
```
// 条件式に使う変数の初期化処理
var count = 0;
while (count < 6) {
    // 繰り返し処理
    console.log(count);
    // 条件式に使う変数の値の更新
    count = count + 1;
}
```
1.`while (count < 6)`の条件を満たしているか確認する。満たしている場合2.の動作を行う。満たしていない場合はそこで`{}`の処理はスキップする
2.countを表示する
3.countに1を追加する
4.1.に戻る
よって表示されるのは
```
0
1
2
3
4
5
```
となる
`count = count + 1`がないと無限ループになってしまうため気をつけること
```
var count = 0;
while (count < 6) {
    // 繰り返し処理
    console.log(count);
    // 条件式に使う変数の値の更新
    count = count + 1;
}
console.log("last:" + count);
```
とすると
```
0
1
2
3
4
5
last:6
```
と表示される。最終的に`count`に代入されている数値は`6`となる

## while文2
条件式を満たし続けない場合、強制的に処理を中止する
終了条件を考えてプログラムを書くこと

## RPGの攻撃シーンを作る
```
var hp = 30;
while(hp > 0){
    let damage = Math.floor(Math.random() * 10 );
    console.log("スライムに" + damage + "のダメージを与えた");
    hp -= damage;
}
console.log("スライムを倒した！")
```
`Math.random`は0~1の数値をランダムに取得できる。0.1234235や0.5342353が取得されるため、1の位に整数がくるようにしている
`Math.floor`はその値よりも小さい値のうち一番近い整数を返す機能。整の値の場合、小数点以下を切り捨てた値になる。
これによって`Math.random`に10をかけて取得できる値の整数部分のみを取得している
`let`は`var`と同様に変数を宣言するときに使用する。意味合いは微妙に違う。

## for文
for文は以下のように記述する
```
for(条件式に使う変数の初期化処理; 条件式; 条件式に使う変数の値の更新){
  //繰り返し処理
}
```
while文の内容を1行で書くことができる
`count = count + 1`
`count += 1`
`count++`
これらは全て同じ意味
```
var count = 0;
while(count < 6){
  console.log(count);
  count++
}
```
このwhile文をfor文にすると
```
for(var count = 0; count < 6; count++){
  console.log(count);
}
```

## 標準入力
JavaScriptはブラウザ上のみでなく、サーバー上でも実行できるようになってきている
それに使用されるのがNode.jsというJavaScript環境
外部から標準入力からデータを受け取るときは
```javascript
//標準入力で外部からデータを受け取る時に必要な記述
process.stdin.resume();
process.stdin.setEncoding('utf8');

//あとで標準入力から渡されたデータを代入しておくために使用
var input_string = "";
//`reader`という変数は`require`という処理を使って`readline`という処理を使えるようにしている
//`readline`を使うと標準入力からデータを簡単に受け取ることができる
var reader = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});
//input_string変数にlineという変数の値を代入している
reader.on('line', (line) => {
    input_string = line;
});
//受けとったデータの処理
reader.on('close',() => {
    console.log("hello " + input_string);
});
```
このように記述する
標準入力で渡されるデータは文字列になるため下記のように記述して標準入力から10を受け取ると`10100`と表示される。
```
var input_string = "";
var reader = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});
reader.on('line', (line) => {
    input_string = line;
});
reader.on('close',() => {
    var result = input_string + 100;
    console.log(result);
});
```
JavaScriptでは`parseInt`関数で文字列を数値に変換することができるため下記のように記述することで`110`となる
```
var input_string = "";
var reader = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});
reader.on('line', (line) => {
    input_string = line;
});
reader.on('close',() => {
    var input_int = parseInt(input_string);
    var result = input_int + 100;
    console.log(result);
});
```

## 標準入力から複数行のデータを受け取る
標準入力から2行以上のデータを受け取るときは**配列**に格納する
```javascript
process.stdin.resume();
process.stdin.setEncoding('utf8');

var lines = [];
var reader = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
});
reader.on('line', (line) => {
    lines.push(line);
});
reader.on('close', () => {
    console.log("hello " + lines[0]);
    console.log("hello " + lines[1]);
});
```

## 西暦年と平成年の対応表を作る
```javascript
for(var seireki = 1989; seireki < 2019; seireki++){
    let heisei = seireki - 1988;
    console.log("西暦" + seireki + "年は平成" + heisei + "年です");
}
```
