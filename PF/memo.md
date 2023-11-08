### group_requests(中間テーブル作成)


### request機能実装


### ユーザーのグループ分け判別方法
・ルーティングでGroupにRequestをネストさせる
必ずGroupの下にRequestができるので、勝手にgroup_id, user_idを取得できる
これだとURLにグループ番号が出てしまうデメリット

・セッションを利用したグループ分け
Request登録前になんらかの方法でセッションにgroup_idを登録しておいて、Request登録画面でそのセッションを取得してgroup_idを特定
こっちのほうがなんとなくイメージに近い。以下GTP
```ruby
session[:selected_group_id] = @selected_group.id

# イベント登録フォームでセッションからグループIDを取得
<%= form.hidden_field :group_id, value: session[:selected_group_id] %>
```

### requestをグループごと表示実装


### userがgroupを切り替える機能実装


### 個人カレンダー機能
グループ毎のrequestまた、選択した（全てでも）グループのrequestがカレンダーになって表示される機能

### 11/7技術面談
userのネストにrequest
userに全ての情報を持たせてそこから必要な情報を取得してくる
グループ選択をすることで取得するデータをグループで属性分けして取得しtopページに出力する
