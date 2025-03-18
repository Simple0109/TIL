# 概要

Dart の文字列は`string`クラスで表現する
Dart の文字列は不変（immutable）なので、文字列に対して処理を行う場合は、元の文字列を変更するのではなく新しい文字列が返される

### immutable とは

作成後にその状態を変えることのできないオブジェクトのこと。
対義語は`mutable（可変）`
immutable を実装するには`final`,`const`を使用する
`final`:一度値を設定すると変更できなくなる
`const`:完全定数として扱われ、コンパイル時に決まった不変の値となる

## 文字列の定義

```dart
final String mozi = '文字列'; // 一般的にシングルクオートを使用する。ダブルクオートでもOK。

final String mozi2 = """複数行の文字列
はこのようにして
書く""";

final String mozi3 = "複数行の文字列\nはこのようにして\n書く";
print(mozi1 == mozi2); // true

// クォートにrを付けることで、エスケープシーケンスを適用しない「生文字列」にできる。
final s5 = r"複数行\nの\n文字列ではない'; // 複数行\nの\n文字列ではない
```

## 文字列の連結と値の埋込

単純な文字列の連結は `+` を使う

```dart
final string1 = 'Dart' + 'は' + 'ダート' + 'です。';
// 文字列を並べるだけでも連結はできる
final string2 = 'Dart' 'は' 'ダート' 'です。';
```

文字列を埋め込んだ変数を表示するときは `$hoge` を使用する

```dart
final string3 = "ほげほげしましょう";
print('$string3');
// => ほげほげしましょう

// 波括弧を使うことで変数にメソッドが使える
print('$string3は${string3.length}文字');
// => ほげほげしましょうは9文字
```

## 文字列を調べる
```dart
final s = "みぎみぎひだりひだり";

// 指定した文字列が含まれるか否か調べる
print(s.contains("みぎ")); // true
print(s.contains("うえ")); // false

// 指定した文字列で始まるか否かを調べる
print(s.startWith("みぎ")); // true
print(s.startWith("ひだり")); // false

// 指定した文字列で終わるか否かを調べる
print(s.endWith("ひだり")); // true
print(s.endWith("みぎ")); // false

// 指定した文字列が最初にでてくるインデックスを取得する
print(s.indexOf("みぎ")); // 0
print(s.indexOf("ひだり")); // 4
// 2番目の引数に整数を渡すと、そのインデックスから検索を開始する
print(s.indexOf("みぎ", 1)); // 2
print(s.indexOf("ひだり", 5)); // 7
```

## 文字列の一部を取得
```dart
final s = "あいうえお";

print(s[1]); // い
// 文字列の長さより大きい値を指定すると実行時エラーが起きる
// print[100]; (エラー)

// 指定したインデックス以降の文字列（末尾まで）を取得する
print(s.subString(2)); // うえお
// 2番目の引数（end）に整数を渡すと、それ未満までの文字列を取得できる
print(s.subString(2, 4)); // うえ
// endに不正な値（負の値、1番目の引数より小さな値、文字列の長さよりも大きな値）を指定すると実行時エラーとなる。
```

## 文字列の分割
```dart
final s0 = "";
final s1 = "Hello Dart World";
final s2 = "あいいう";

print(s1.split(" ")); // ["Hello", "Dart", "World"]
print(s2.split("い")); // ["あ", "", "う"]
// 空文字を渡すと全ての文字で分割できる
print(s2.split("")); // ["あ", "い", "い", "う"]
```

## 文字列の置き換え
```dart
final s = "うえうえしたした";


print(s.replaceFirst("した", "ひだり")); // うえうえひだりした

// 第三引数にstartindexを渡すとそのインデックス以降に見つかった最初の文字列を置き換えする
print(s.replaceFirst("した", "ひだり", 5)); // うえうえしたひだり

// 一致したすべての文字列を置き換え
print(s.replaceAll("した", "ひだり")); // うえうえひだりひだり
```