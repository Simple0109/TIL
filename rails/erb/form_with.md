### アソシエーションを結んでいるモデルのデータを使用する
```ruby
<%= f.collection_select(メソッド名, オブジェクトの配列, value属性の項目, テキストの項目 [, オプション or HTML属性 or イベント属性]) %>
```
具体例
```ruby
<%= form_with model: @request, url: requests_path, local: true do |f| %>
  <%= f.label :group_id%>
  <%= f.collection_select :group_id, current_user.groups, :id, :name, prompt: "Select Group" %>
<%end%>
```
[Railsガイド](https://railsguides.jp/form_helpers.html#collection-select%E3%83%98%E3%83%AB%E3%83%91%E3%83%BC)
みてもよくわからんん
[参考サイト](https://qiita.com/ohnitakahiro/items/c536fe65e37980e1087e)

```ruby
<%= f.collection_select :group_id, current_user.groups, :id, :name, prompt: "グループを選んでください" %>
```
`:group_id` : selectタグのid属性, name属性が決まる `<select name="○○" id="◯◯">`
`current_user.groups` : 選択肢の配列を決める　`@groups = Group.all`のように定義しているモデルから持ってきてもいい
`:id` : 選択された場合この値がDBに送信される。今回は:idなので:idが送られる
`:name` : 実際に選択肢に表示される内容
`prompt` : 初期に表示させる文字列
