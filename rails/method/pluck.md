### pluck
[公式ドキュメント](https://railsdoc.com/page/model_pluck)
指定された絡むの値を直接データベースから取得し、ActiveRecordオブジェクトのインスタンス化せずに値の配列として返す

```ruby
# ユーザーIDを取得
user_ids = User.pluck(:id)
#=> [1,2,3,4,5,.....]

# 特定の投稿すべての湖面ろIDを取得
comment_ids = Post.find(1).comments.pluck(:id)
#=> [10, 11, 14, 15, ...]
```

mapメソッドを使ってpluckメソッドと同じ処理を行うことができるが、mapメソッドの場合モデルインスタンスが生成されるため、パフォーマンスがいいのはpluckメソッド
```ruby
# カンマ区切りでBookモデルのnameをすべて取得し描画する
# インスタンスを生成し、メモリにロードするためパフォーマンスが悪い
<%= Book.all.map(&:name).join(",") %>

# nameの値の配列がかえる
# インスタンスは生成していないため高速
<%= Book.pluck(:name).join(",") %>
```
※pluckは必ずSQLを発行するために一覧画面の個々の要素を処理する場合は(preloadしたうえで)mapを使うのもOK

