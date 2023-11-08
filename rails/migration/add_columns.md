## 既存テーブルにカラムを追加する時
1.
`rails g migration add_columns_マイグレーションファイルの名前_to_追加したいテーブル名 カラム名:データ型`
`rails g migration add_columns_references_info_to_requests user:references group:references`
でマイグレーションファイルができる

2.
`rails g migration add_columns_to_テーブル名`
`rails g migration add_columns_to_requests`
で作成されたマイグレーションファイルに必要情報を追記して`rails db:migrate`

### 追加カラムがreferences型の時
2.の方法でカラムを追加し、追加したいカラムのデータ型がreferences型の場合
**add_reference**と**foreign_key: true**忘れないように
```ruby
class AddColumnsToRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :request, :user, foreign_key: true
    add_reference :request, :group, foreign_key: true
  end
end
```