# 導入方法
```
rails new app_name --css tailwind
```
これで`rails new`することで初期のGemfileに`gem "tailwindcss-rails"`が追加される（実際はコメントアウトが外れるのかも？？）

次に公式通り
```shell
$ npm i -D daisyui@latest
```
を実行
`i`は`install`の略称
`-D`はパッケージを開発用の依存関係としてインストールするためのオプション
パッケージをプロジェクトの`package.jsonファイル`の`devDependenciesセクション`に追加する
開発用の依存関係は通常プロジェクトを開発するために必要だが、本番環境では必要ないライブラリやツール
例えば、テストライブラリやビルドツールは、開発時には必要ですが、本番環境では実行する必要がないことがある
そういったツールやライブラリを開発用の依存関係として指定することで、本番環境へのデプロイ時に余分なコードやライブラリを含めないようにすることができる
「-D」オプションは、開発時に必要ながらも、本番環境では不要なパッケージを管理するためのもの

`config/tailwind.config.js`に以下のように追記する
```ruby
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require("daisyui"), # ここを追加！！！カンマ忘れるな！！！
  ]
}

```