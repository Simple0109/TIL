## Rubocop
`.rubocop.yml`という名前のファイルに書かれた設定に従ってソースコードの検査を行う
例えば「このファイルは検査対象外としたい」「デフォルトの検査は厳しすぎる」といった時に、この設定ファイルにより適宜調整を行うことが可能
また、チーム開発ではこの設定ファイルを共有しておくことで、チーム内でソースコードの品質を一律に保つことができる
まずGemfileの`group :development do`の配下に以下のように追記し`$ bundle install`を行う
```
group :development do
  ...
  gem 'rubocop', require: false # 追加
  gem 'rubocop-performance', require: false # 追加
  gem 'rubocop-rails', require: false # 追加
  gem 'rubocop-rspec' # 追加
end
```
Gemfileに上記を記述し`bundle install`を行っただけでは設定ファイルは追加されないためプロジェクト配下ディレクトリで`$ touch .rubocop.yml`を行わなければならない
設定に関しては[こちら](https://blog.to-ko-s.com/rubocop-setting/)を確認

rubocopを使うときは`$ bundle exec rubocop`を実行する
