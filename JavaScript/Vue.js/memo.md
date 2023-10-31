## dataプロパティ
Vue.jsのコンポーネント内で`data`というプロパティを定義するとそれはそのコンポーネントのためのリアクティブ（変化を自動的に追跡し、ビューに反映する）データオブジェクトになる
コンポーネントのインスタンスないでこれらのプロパティを操作することでユーザーインターフェースを自動的に更新される
```javascript
export default {
  data(){
    return {
      count: 0,
      message: "Hello, Vue!"
    };
  },
};
```
上記のように`count`と`message`の2のデータプロパティを定義する
これらのプロパティではコンポーネントのテンプレート内で使用することができ、コンポーネントのメソッド内で操作を行うことができる
ボタンを押すことで`count`の値を増やす処理を`method`内で書いてボタンをクリックするたびに`count`の値が増えるようにすることができる
`data`はVueコンポーネントの重要な概念でVueのリアクティブなシステムの基礎を形成する
このリアクティブなシステムによりデータが変更されると関連する部分のビューが自動的に更新される

## props
Vue.jsの`props(プロパティ)`は親コンポーネントから子コンポーネントへデータを渡すためのもの
実際にはJavaScriptオブジェクトとして定義され、そのキーが子コンポーネント内でのプロパティ名、値がプロパティ形となる

例えば親コンポーネントから子コンポーネントへメッセージを渡したい場合、子コンポーネントの`propsオプション`を以下のように定義する
```javascript
props: ['message']
```
親コンポーネントでは、子コンポーネントを使用する際に`v-bind`(または省略形の`:`)を使ってデータを渡します
```javascript
<ChildComponent :message="parentMessage" />
```
このようにすると、親コンポーネントの`parentMessage`が子コンポーネントの`message`として渡され、子コンポーネント内でその値を使うことができる
子コンポーエンとでは、propsぷションで定義したプロパティを`this`を用いて参照する
```javascript
export default {
  props: ['message'],
  mounted(){
    console.log(this.message)
  },
};
```
### プロパティのメリット
1.データの流れが一定方向にあんる
propsを用いることでデータは親から子へ１方向に流れることになる。これによりデータが追いやすくなろデバッグが容易になる
2.再利用可能性の向上
同じ子コンポーネントを異なる親コンポーネントから使い回すことができる
子コンポーネントが親から渡されたpropsによって動作を変えられるため、より汎用的なコンポーネントを作成することができる
3.明示性の向上
propsはコンポーネントが受け入れる外部パラメータを明示的に示す。これによりコンポーネントのAPiが明確になり、それがどのようなデータを要求するのかが容易に理解できる

## thenメソッド
`.then`はPromise(非同期処理)が成功した場合に実行されるコードを指定する
Promiseは非同期処理が完了した後に成功(resolve)または失敗(reject)となり`.then`はその成功時の処理を記述します

## responseメソッド
`response`は非同期リクエストの結果を含むオブジェクト。例えばHTTPリクエストの場合、レスポンセのデータは`response.data`に格納される
```javascript
axios.get('http://example.com/api/data')
  .then(response => {
    //response オブジェクトからデータを取得
    console.log(response.data);
  })
```

## catchメソッド
`.catch`はPromiseが失敗した場合に実行されるコードを指定する。非同期処理がエラー(reject)となった場合に
`.catch`に渡された関数が呼び出されます
```javascript
axios.get('http://example.com/api/data')
  .then(response => {
    //成功した場合の処理
    console.log(response.data)
  })
  .catch(error) => {
    console.error(error);
  };
```

## console.error(error)
`console.error`はコンソールにエラーメッセーぞを表示するメソッド
非同期処理が失敗し、`.catch`で処理された場合にエラーメッセージがコンソールに表示される
```javascript
axios.get('http://example.com/api/data')
  .then(response => {
    //成功した場合の処理
    console.log(response.data);
  })
  .catch(error => {
    //エラーが発生した場合の処理
    console.error(error);
  });
```

### SFCとはなにか
**SFC**とは**単一ファイルコンポーネント(Single File Component)**の略称
Vue独自のフォーマットでコンポーネントを定義する方法の1つ
```javascript
<template>
  <div class="title">{{ msg }}</div>
</template>

<script>
  export default {
    data(){
      return {
        msg: "Hello world!"
      },
    },
  };
</script>

<style>
  .title{
    color: blue;
  }
</style>

```
上記のコードのようにSFCでは`<template>`,`script>`,`<style>`の3つのブロックからコンポーネントが構成されているのが大きな特徴

それぞれのブロックについて解説
`<template>ブロック`
HTMLで記述する表示要素

`<script>ブロック`
JavaScriptで記述するロジック要素
scriptタブにsetup属性を指定することで**CompositionAPI**を使うことができる
**CompositionAPI**とはVue3より標準導入された機能であり、ロジックごとに切り出すことが可能な関数ベースでコンポーネントの実装できる構成

`<style>ブロック`
CSSを記述する場所
<style>内で定義した<template>内のHTMLに反映される