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
