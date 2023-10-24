## importmap-railsとはなんなのか
Ruby on Rails7.0から`import maps`が標準になった
`import maps`とは
```
Import mapsは JavaScript (ES6) の import 文や import() 式で取得するモジュール(ESModules)の URL を制御することができるWeb標準です。 現状では Chrome系ブラウザでのみサポートされているのみですが、他のブラウザでも ES Module Shims という Polyfill を使うことで利用できます。
```
と説明があったがうまく理解できずさらに調べる。
```
JavaScriptのモジュールはコードを複数のファイルに分割し再利用可能で保守しやすいコードを書くための手段
モジュールは他のモジュールから必要な部分をimportして利用することができる

import maps`はこれらのモジュールがどこから読み込まれるかを管理するもの
通常JavaScriptのモジュールは相対パスや絶対パスをもって指定されるが、import mapsを利用することでモジュールの実際のURLをより柔軟に制御できる

例えばRuby on Railsの場合、import mapsを使って特定のライブラリやモジュールを読み込むとき、そのURLをimport mapsに定義することができる
これにより後でURLが変更されてもimport mapsだけを更新すればコードの修正が不要になる
```

**HTML**
`"パッケージ名":"取得先のURL"`を列挙してブラウザに伝える
```html
<script type="importmap">{
  "imports": {
    "application": "/assets/application-12345.js",
    "components": "/assets/components/index-12345.js",
    "components/hello": "/assets/components/hello-12345.js",
    "react": "https://ga.jspm.io/npm:react@17.0.2/index.js",
    "react-dom": "https://ga.jspm.io/npm:react-dom@17.0.2/index.js",
    "object-assign": "https://ga.jspm.io/npm:object-assign@4.1.1/index.js",
    "scheduler": "https://ga.jspm.io/npm:scheduler@0.20.2/index.js",
  }
}</script>
<script type="module">
  // "application" から "/assets/application-12345.js" を解決、取得して実行
  import "application";
</script>
```
`<script type="importmap">`タグ内でimport mapが定義され`<script type="module">`タグ内でそれを利用してモジュールを読み込んでいる

Ruby on Rails7.0では`rails new`すると標準で`importmap-rails`が使用できる
`importmap-rails`では`config/importmap.rb`にDSLを使ってマッピングの設定を記載する。
>※DSL:Domain-Specific Language(ドメイン固有言語)
>importmap-railsでのconfig/importmap.rbにおけるDSLは、Rubyを使ってImport mapの設定を行うための専用の言語や文法を指しています。このDSLを使用することで、Rubyのコードを使ってImport mapを効率的に構築できます
そしてビューで`javascript_importmap_tags`ヘルパーを使い
・importmap (<script type="importmap">{...}</script>)
・プリロードさせるモジュールのためのscriptタグ
・ES Module Shims 用の Content Security Policy nonce (CSPが設定されているとき)
・ES Module Shims を読み込むためのscriptタグ
・エントリーポイントのためのscriptタグ (<script type="module">import "application";</script>)
を生成します。