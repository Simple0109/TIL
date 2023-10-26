## ライフサイクルフック
**ライフサイクルフック**はコンポーネントの一生に関する特別な関数
・作成
・更新
・削除
等それぞれのステップでコードを実行する
**ライフサイクルフック**を使うことでコンポーネントがどの段階にあるのかを把握し、必要な処理を行うことができる

### ライフサイクルフックの種類
・beforeCreate:コンポーネントが作成される直前に呼び出される
・created:コンポーネントが作成された直後に呼び出される
・beforeMount:コンポーネントがDOMに取り付けられる直前に呼び出される（※DOMに取り付けることを**マウントする**と呼ぶ）
・mounted:コンポーネントがDOMに取り付けられた直後に呼び出される
・beforeUpdate:コンポーネントが再描写される直前に呼びだされる
・updated:コンポーネントが再描写された直後に呼び出される
・beforeUnmount:コンポーネントがDOMから除去される直前に呼び出される
・unmounted:コンポーネントがDOMから除去された直後に呼び出される

### ライフサイクルフックの使い方
**setupを使わない場合**
```javascript
//ライフサイクルフックの名前(){ライフサイクルフックで実行したい処理}
created(){
  console.log("created フック: コンポーネントが初期化された直後");
},
```
**setupを使う場合**
```javascript
//beforeCreate,createdは<script>直下にそのまま書く
console.log("beforeCreate フック: コンポーネントが初期化される直前");
console.log("created フック: コンポーネントが初期化された直後");
//beforeMount以降はそれぞれのフック名に「on」をつけたメソッドを使用し、その中に処理を描く
onBeforeMount(()=> {
  console.log("beforeMount フック: DOMにマウントされる直前");
});
```

※これらのメソッドは`import`する必要があるので気をつけること
```javascript
<script setup>
import { ref, onBeforeMount, onMounted, onBeforeUpdate, onUpdated } from "vue";
```
