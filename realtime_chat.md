`npm init vue@3`というコマンドは
`npm init`
npm(Node Package Manager)の初期化コマンドで新しいプロジェクトを作成するためのコマンド
`vue@3`
Vue.jsのバージョン3を指定している。



package.json内の
```javascript
"scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs --fix --ignore-path .gitignore",
    "format": "prettier --write src/"
  },
```
`"dev": "vite"`部分を`"dev": "vite --port 3001"`と変更することにより
`npm run dev`でサーバーを起動するときのURLが`localhost:3001`に変更できる

## フロント(Vue.js)とバック(Rails)が通信できるように設定する
CORS(Cross-Origin Resource Sharing)の設定を行う
>CORS (Cross-Origin Resource Sharing)とは、異なるオリジン（ドメイン・ポート・プロトコル）間での通信を許可する仕組みです。
>例えば、http://localhost:3000からhttp://localhost:3001への通信は、異なるオリジン間の通信になります。
>この場合、予期せぬオリジン（リクエスト元）からの通信をブロックするため、RailsアプリケーションではデフォルトでCORSが有効になっています。
>そのため、CORSの設定を行う必要があります。

### Railsにおけるrack-corsの設定
backendのGemfileでコメントアウトされている`gem 'rack-cors`のコメントアウトを外す
backendのターミナルで`bundle install`を実行

次にVue.jsからのリクエストを許可するための設定を行う
Vue.jsは`http://localhost:3001`で動作することを想定しているので`rack-cors`の設定もそのようにする。
railsディレクトリ内の`config/initializers/cors.rb`を開き内容を以下のように変える
```
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3001' # Vue.jsを動作させているアドレスとポート番号

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```
これにより`localhost:3001`からの全ての種類のリクエストを許可する
以下コード解説

```
このコードは、RailsアプリケーションでCORS（Cross-Origin Resource Sharing）を設定しています。CORSは、異なるオリジン（ドメイン、プロトコル、ポートが異なる場所）からのリクエストに対する制御をブラウザに指示するための仕組みです。具体的には、このコードはRack::Corsミドルウェアを使用しています。

具体的な設定は以下の通りです：

1. **`Rails.application.config.middleware.insert_before 0, Rack::Cors do`**: CORSの設定を行うために、Rack::Corsミドルウェアをアプリケーションのミドルウェアスタックの先頭（0番目）に挿入します。

2. **`allow do`**: 許可の設定を行うためのブロックが始まります。

3. **`origins 'localhost:3001'`**: このアプリケーションに対して許可するオリジン（アクセス元のドメインとポート番号）を指定しています。この場合、`localhost:3001`からのアクセスを許可しています。

4. **`resource '*'`**: 許可するリソース（URIパターン）を指定しています。`'*'`はすべてのリソースを指します。

5. **`headers: :any`**: 許可するHTTPヘッダーを指定しています。`:any`はすべてのヘッダーを許可することを示します。

6. **`methods: [:get, :post, :put, :patch, :delete, :options, :head]`**: 許可するHTTPメソッドを指定しています。一般的なRESTfulな操作に関連するメソッドを許可しています。

この設定により、Vue.jsアプリケーション（`localhost:3001`）からのリクエストがこのRailsアプリケーションに対してCORSのポリシーに違反しないように設定されています。
```

これによってフロントエンドとバックエンドの連携が完了
現状ではそれぞれ別のサーバーで動作しているため、Vue.jsからRailsへの通信ができるかどうか不明
Vue.jsとRailsの連携を確認するためにテスト用のAPIを作成する
