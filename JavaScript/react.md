# React
## ブラウザに表示される仕組み
`App.js`に書かれているjsxは`index.js`を通じて`index.js`に変換される　　
つまりReactのコードを実際にブラウザに表示するためには`index.js`と`index.html`というファイルが必要になる　　
```
React - index.html
      |- src - index.js
             |
             -components - App.js
```
コンポーネントファイルをhige.jsファイルを作成した場合は　　
hoge.js - App.js - index.js -inde.html  
の順番で呼び出されブラウザに表示される

