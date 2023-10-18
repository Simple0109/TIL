### Section6 オプションの構成
```javascript
var app = new Vue({
  //mountする要素。#appはHTML内の要素
  el: '#app',

  //アプリケーションで使用するデータ
  data: {
    message: 'Vue.js'
  },

  //算出プロパティ
  computed: {
    computedMessage: :function(){
      return this.message + '!'
    }
  }

  //ライフサイクルフック
  created: function(){
    //行いたい処理
  },

  //アプリケーションで使用するメソッド
  methods: {
    myMethod: function(){
      //行いたい処理
    }
  }
})
```
`mount(マウント)`
新しいVueインスタンスをHTML要素に関連付け初期化することを指す
VueインスタンスがHTML要素に取り付けられることでその要素とVueインスタンスが結びつき
データバインディングやイベントの監視などが可能になる
「mountする」はVue.jsが管理する対象となる要素を指定し、Vue.jsがその要素を制御するための準備を整えること


`el(マウントする要素)`
アプリケーションを紐づける要素のセレクタ

`data(データ)`
アプリケーションで使用するデータ。オブジェクトや配列も登録できる
```javascript
new Vue({
  el: '#app'
  data: {
    message: 'Vue.js'
  }
})
```

`computed(算出プロパティ)`
`data`と似たように扱うことのできる、関数によって算出されたデータ

```javascript
new Vue({
  el: '#app',
  computed: {
    computedMessage: function(){
      //何か処理した結果をデータとして返す
      return this.message + '!'
    }
  }
})
```

`created -ライフサイクルフック`
ライフサイクルとはVue.jsの最初から最後までの一定のサイクルを表すもの
ライフサイクルフックはあらかじめ登録した処理をVueインスタンスの特定のタイミングで自動的に呼び出す
こうした処理を割り込ませる仕組みを`フック（決まったタイミングに処理を割り込ませる）`と呼ぶ
`created`はライフサイクルフックのうちの1つ
このメソッドを登録したVueインスタンスが作成されデータの監視などリアクティブまわりの初期化が終わった後に呼び出される
```
※リアクティブ」とは、Vue.jsにおいて特定のデータが変更された際に、それに依存する他の部分が自動的に更新される仕組みを指します。つまり、データの変更があると、それに連動して関連する表示や動作が更新されるという特性を指します。
```
```javascript
new Vue({
  el: '#app'
  created: function(){
    //このインスタンスの作成＆初期化が終わったらすぐ
    console.log('created')
  }
})
```
`data`や`method`は自由に定義できるが、ライフサイクルフックは使用できるメソッドが決まっている
詳しくは基礎から学ぶVue.jsの46P

`method（メソッド`
アプリケーションで使用するメソッド
コードを管理しやすくするために処理を分けたりイベントバンド等など細かな実装を担当する
```javascript
new Vue({
  el: '#app'
  method: {
    myMethod: function(){
      //処理
    }
  }
})
```