### filterメソッド
配列内の各要素に対して指定さえrた条件を満たす要素だけを抽出して新しい配列を生成するメソッド
このメソッドは非破壊的で元の配列は変更されず、新しい配列が返される
```javascript
const numbers = [1,2,3,4,5]

//偶数だけを抽出する
const evenNumbers = numbers.filter((number) => number % 2 == 0);
console.log(evenNumbers); //[2,4]
```