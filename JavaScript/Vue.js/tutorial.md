### 宣言的レンダリング
```javascript
<script type="module">
import { createApp } from 'vue'

createApp({
  data(){
    return{
      message: 'Hello World',
      counter: {
        count: 0
      }
    }
  }
}).mount('#app)
</script>

<div id="app">
  <h1>{{ message }}</h1>
  <p>Count is: {{ counter.count }}</p>
</div>
```
**`{{}}`->mustaches（マスタッシュ）構文**
mustaches構文の内容は識別子やパスに限られない。Javascriptの式であれば使える
`<h1>{{ message.split('').reverse().join('') }}</h1>`

### 算出プロパティ
```javascript
<script setup>
import { ref, computed } from 'vue'

let id = 0

const newTodo = ref('')
const hideCompleted = ref(false)
const todos = ref([
  { id: id++, text: 'Learn HTML', done: true },
  { id: id++, text: 'Learn JavaScript', done: true },
  { id: id++, text: 'Learn Vue', done: false }
])

const filteredTodos = computed(() => {
  // 三項演算子を使って`hideCompleted.value`がtrueの時とfalseの時で場合分けしている
  return hideCompleted.value
    // trueの場合、filterメソッドを使って、todosリストの内容からdoneプロパティがfalseのもののみを抽出している
    ? todos.value.filter((t) => !t.done)
    // falseの場合、todosリストはそのまま
    : todos.value
})

function addTodo() {
  todos.value.push({ id: id++, text: newTodo.value, done: false })
  newTodo.value = ''
}

function removeTodo(todo) {
  todos.value = todos.value.filter((t) => t !== todo)
}
</script>

<template>
  <form @submit.prevent="addTodo">
    <input v-model="newTodo">
    <button>Add Todo</button>
  </form>
  <ul>
    <li v-for="todo in filteredTodos" :key="todo.id">
      <input type="checkbox" v-model="todo.done">
      <!-- todo.doneがtrueの場合、doneクラスが付与（横線）される -->
      <span :class="{ done: todo.done }">{{ todo.text }}</span>
      <button @click="removeTodo(todo)">X</button>
    </li>
  </ul>
  <button @click="hideCompleted = !hideCompleted">
    {{ hideCompleted ? 'Show all' : 'Hide completed' }}
  </button>
</template>

<style>
.done {
  text-decoration: line-through;
}
</style>
```

### ライフサイクルとテンプレート参照
テンプレート参照するにはコンポーネントをマウントしたあとでなければならない
**※マウントする**
Vueインスタンスやコンポー円とがDOMに挿入され、表示される準備が整った状態を指す
DOMへの挿入はVueが管理する仮装DOMが実際のDOMに反映されるときに行われる
```javascript
<script setup>
import { ref, onMounted } from 'vue'

const pElementRef = ref(null)

onMounted(() => {
  pElementRef.value.textContent = 'mounted!'
})
</script>

<template>
  <p ref="pElementRef">hello</p>
</template>
```
この状態では`pElementRef`はまだマウントされておらず、templateタグ内で表示することができない
マウントしたあとのコードを実施したい場合は、`onMounted()関数`を使ってマウントしてあげる必要がある

```javascript
<script setup>
import { ref, onMounted } from 'vue'

const pElementRef = ref(null)

onMounted(()=>{
  pElementRef.value.textContent = ""
})

</script>

<template>
  <p ref="pElementRef">hello</p>
</template>
```
※`textContent`はDOM要素のプロパティでその要素のテキストコンテンツ（中のテキスト）を取得または設定するためのもの

### ウォッチャー
数値が変化したときにコンソールにログを記録するといった副作用をリアクティブに実行しなければならない場合がある
その場合`ウォッチャー`で実現できる
```javascript
import {ref ,watch} from "vue"

const count = ref(0)

watch(count, (newCount) => {
  console.log(`new count is: ${newCount}`)
})

```

`asyns`はJavaScriptにおいて非同期処理を実現するためのキーワード
`asyns`を関数の前につけることによって、その関数は必ずPromiseを返すようになる
また`await`キーワードを使って非同期処理が完了するまで一時停止できます
`await`

### コンポーネント
親コンポーネントはそのテンプレートにある別のコンポーネントを子コンポーネントとしてレンダリングすることができる
その場合まずそれをインポートする必要がある
```javascript
<script setup>
import ChildComp from "./ChildComp.vue"
</script>

<template>
  <ChildComp />
</template>
```

### props
子コンポーネントは親コンポーネントからpropsを介して入力を受け取ることができる
まず受け入れるpropsを宣言する必要がある
```javascript
<script setup>
const props = defineProps({
  msg: String
})
</script>
```

### コンポーネント
親コンポーネントはそのテンプレートにある別のコンポーネントを子コンポーネントとしてレンダリングすることができる
子コンポーネントを使用するにはまずそれをインポートする必要がある
`import ChildComp from "./ChildComp.vue`
そしてそのコンポーネントをテンプレート内で次のように使用することができる
`<ChildComp />`

### Props
子コンポーネントは親コンポーネントから`props`を介して入力を受け取ることができる
まず受け入れるpropsを宣言する必要がある
```javascript
//子コンポーネント
<script setup>
const props = defineProps({
  msg: String
})
</script>

<template>
  <h2>{{ msg || test }}
</template>
```
```javascript
//親コンポーネント
<script setup>
import { ref } from "vue"
import ChildComp from "./ChildComp.vue"

const greeting = ref("Hello World!")
</script>

<template>
  <ChildComp :msg="greeting" />
</template>
```
このようにすることでChildComp.vueで`Hello World!`と表示される
