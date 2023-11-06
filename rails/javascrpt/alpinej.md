## Alpine.jsの導入方法(Rails7系importmap使用時)
### importmap導入
Gemfileに`gem "importmap-rails"`を追記して`$ bundle`
`$ rails importmap:install`を実行
※`$ rails --tasks`でrailsコマンドで実行できる一覧が確認できる。そこに`rails importmap:install`があれば間違いなくおk

### yarn(もしくはnpm)でalpinejs導入 -> importmap.rbに追記
`$ yarn install alpinejs`を実行
`$ bin/importmap pin alpinejs`を実行

### application.jsに追記
```javascript
import Alpine from 'alpinejs'

window.Alpine = Alpine
Alpine.start()
```
上記内容を追記するとalpinejsが使えるようになる
