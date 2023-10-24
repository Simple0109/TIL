## RSpec
RSpecはRubyやRailsで使用する代表的なテストフレームワークの１つ
RubyではMinitestというライブラリを標準で使えるが、RSpecはMinitestと比べて機能が豊富で直感的にテストを読み書きできることから人気のフレームワーク

### RSepcのインストール
Gemfileの`group :development, :test do`配下に以下のように記述し`$ bundle install`
```
group :development, :test do
  ...
  gem 'rspec-rails' # 追加
end
```
`$ bundle install`が正常に終わったらRSpecを動かすために必要なファイル群を`$ bundle exec rails g rspec:install`で作成する
実行するときは`$ bundle exec rspec`で実行できる

`$ rails g`コマンドでコントローラやモデルを作成する際にRSpecテスト用のファイルを自動生成されるが、アプリによっては不必要なものがある
自動生成したくないテストファイルがある場合`config/application.rb`に追記する。内容は別途

### テスト結果の出力調整
デフォルトからドキュメント形式へ変更（必須ではないがRSpecの出力結果を見やすくする）
Railsプロジェクト直下にある`.rspec`ファイルの最下段に以下の１行を追加する
`--format documentation # 出力結果をドキュメント風に見やすくする`