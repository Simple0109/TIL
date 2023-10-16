### 条件式
JavaScriptで条件に応じた文章を書くときは
```
if(条件式){
  //条件が成り立った時の処置
}
```
と書くことができる
```
var number = 1;
if(number == 1){
  console.log("paiza");
}
```
を実行すると`paiza`が返される
条件を満たさない場合は処理がスキップされる
JavaScriptにおいて`{}`の間はひとまとまりの処理である
条件が成立しない場合の処理を書くときは
```
var number = 1;
if(number == 1){
  console.log("paiza");
} else{
  console.log("runteq");
}
```
他の処理を記述する場合は
```
var number = 1;
if(number == 1){
  console.log("paiza");
} else{
  console.log("runteq");
  console.log("runteq");
}
```
上記のように続けて処理を記述する。
JavaScriptでは処理を`{}`で囲む

## 複数の条件式
```
var number = 1;
if(number == 1){
  console.log("paiza");
} else{
  console.log("runteq");
}
```
この条件式はnumberが1以外の時に"runteq"が出力されるが、この条件式に追加で条件を追加したいときは以下のようにする
```
var number = 2;
if(number == 1){
  console.log("paiza");
}else if (number == 2) {
  console.log("ishikawa");
}else {
  console.log("runteq");
}
```
このように`else if`を使用することで条件を複数追加することができる。この条件は何個でも追加できる。
条件を満たさない場合は`else`の場合の処理が行われることになる

## 