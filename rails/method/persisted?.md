## persisted?メソッド
ActiveRecord::Baseを継承しているインスタンスが利用可能なメソッド
インスタンスがデータベースに保存されていれば`true`、保存されていなけば`false`を返す

```ruby
モデル.persisted?()

# => DBに保存されていればtrue
# => 保存されていなければfalse
```
trueの例
```ruby
class Person
  include ActiveModel::Model
  attr_accessor :id, :name
end

person = Person.new(id: 1, name: 'bob')
person.save
person.persisted? # => true
```
falseの例
```ruby
class Person
  include ActiveModel::Model
  attr_accessor :id, :name
end

person = Person.new(id: 1, name: 'bob')
person.persisted? # => false
```

### 使用例
persisted?メソッドはtrueもしくはfalseを返すので条件分岐と併用することが可能

```html
<% if @product.persisted? %>
  <div data-index="<%= @product.images.count %>" class="js-file_group">
    <%= file_field_tag :src, name: "product[images_attributes][#{@product.images.count}][src]", class: 'js-file' %>
    <div class="js-remove">削除</div>
  </div>
<% end %>
```
`@product`がデータベース保存されていると画像投稿ボタンと削除ボタンがビューに現れる
