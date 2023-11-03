`link_to(リンクテキスト, パス, [,オプション, HTML属性 or イベント属性])`
例
```ruby
# URLヘルパー指定
link_to "Profile", profile_path(@profile)
# <a href="/profiles/1">Profile</a>

# idとclassを付与
link_to "Articles", articles_path, id: "news", class: "article"
# <a href="/articles" class="article" id="news">Articles</a>

# メソッド固定
link_to("Destroy", "http://www.example.com", method: :delete)
# <a href='http://www.example.com' rel="nofollow" data-method="delete">Destroy</a>
```
### rails7系の場合の使い方
rails7系でメソッドを`delete`に指定して`link_toメソッド`をし使用するとエラーが起きる
解決するには
```ruby
link_to "hoge", "#(path)", data: { "turbo-method": :delete }
```
のように`data: { "turbo-method": :delete }`をつける必要がある
もしくは`link_to`ではなく`button_to`を使えば`data: { "turbo-method": :delete }`をつける必要がないので
```ruby
button_to "hoge", "#", method: :delete
```
でおk