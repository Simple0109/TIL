### ディレクティブ
Vue.jsで使われる特別な属性
HTML要素の属性として使用し、その要素の表示や挙動を制御する
「v-model」のように「v-⚪︎⚪︎」という形式

### v-for
リスト（配列）のデータをループ表示できるディレクティブ
`v-for="変数名 in 配列名`
```javascript
<template>
  <ul>
    <li v-for="fruit in fruitsList" :key="fruit.id">{{ fruit }}</li> //この時の変数名は自由なものを使える
  </ul>
</template>
```
v-forは**key属性**を一緒に使うことが推奨されている
key属性はリストの要素を一意に識別できる->Vueがデータを正しく追うことができる
効率的に描写ができ、リストに変更があった場合に正しく表示を変更できる

### v-if,v-else
**v-if**
条件を使用して要素の表示、非表示を切り替えられるディレクティブ
`v-if="条件`
条件が`true`の場合、その要素は表示される
**v-else**
v-ifのある直後の要素で`v-else`を使うとその条件に当てはまらない場合にv-elseの要素が表示される
```javascript
<script setup>
import { ref } from 'vue'

const awesome = ref(true)

function toggle() {
  awesome.value = !awesome.value
}
</script>

<template>
  <button @click="toggle">toggle</button>
  <h1 v-if="awesome">Vue is awesome!</h1>
  <h1 v-else>Oh no 😢</h1>
</template>
```

### v-show
書き方と振る舞いはv-ifと同じ（※v-elseに相当するものはない）
v-ifとの違いは条件がfalseの時、v-ifは要素自体が存在しないが、v-showは要素は存在するがcssの`display: none;`で非表示になる
v-ifは非表示になるときに削除されるため、再表示するためにかかるコストがv-showと比べて大きい
->条件が頻繁に切り替わるときはv-show,そうでないときはv-ifを使う
