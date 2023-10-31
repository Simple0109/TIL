```javascript
//スタイルの読み込み
//main.cssファイルをインポートしている。アプリケーション全体に適用されるスタイルが定義されている
import './assets/main.css'

// createApp関数を使って新しいVueアプリケーションを作っている
import { createApp } from 'vue'
import App from './App.vue'

//createRouter関数を使ってVue Routerを作成している
//createWebHistoryはHTML5historyモードを使用するためのヘルパー関数で、クライさんとサイドのナビゲーションが可能になる
import {createRouter, createWebHistory } from "vue-router"
import Users from "./components/Users.vue"

//routeオプションで各パスに対するコンポーネントのマッピングを指定している
//このコードではルートパス/にはAppコンポーネントを、/usersパスにはUsersコンポーネントを割り当てている
const router = createRouter({
  history: createWebHistory(),
  routes:[
    { path: "/", component: App },
    { path: "/users", component: Users}
  ]
})

//createApp関数で作成したアプリケーションに先ほど作成したVueRouterを組み込んでいる
//app.use(router)によりVueアプリケーションがRouterを利用できるようになる
const app = createApp(App)
app.use(router)

//VueアプリケーションがHTML文書内の#app要素にマウントされる。これによりVueアプリケーションが表示されるようになる
app.mount("#app")
```