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

### sessionで場合分け
たぶんだけど
ユーザー登録時点でdeviseがユーザーごとにsessionを保存している
ログインしたユーザーのsessionと、登録済みユーザーのsessionを比べてすでにあるsessionかつparamsにgroup_idが含まれていたら
中間テーブルにURLに含まれているgroup_idとログインしたユーザーのuser_idを保存する的な感じ？かな？
それ用のログインフォームを作るのか、通常のログインフォームに
```ruby
# たぶん書き方全然違うけど認識だけ
invite_user_session = [:session]
if invite_user_session == User.find_by([session: current_user[:session]])
```
的なこと
でもsessionってログアウトの段階で削除されるんじゃない？
データベース保存もできるらしい
11/28技術面談
流れ
・準備
groupにtokenカラムを作成
招待リンクを作成したタイミングでtokenカラムにトークンを生成、リンクにトークンを付与
・招待URLを送付し、リンクにアクセス後
付与されたトークンと、groupのtokenカラムを比較し、groupを特定
group_idをsessionに保存(invite_user_session = @group.idとか?)
ユーザーの状態によって（ログイン済み、未ログイン、非登録ユーザー）中間テーブルにgroup_idとuser_idが保存される処理を書く
処理完了後にinvite_session, groupのtokenカラムを削除する

```ruby
class InvitesController < ApplicationController

def new
  @group = Group.find(params[:group_id])
  @group.token = generate_invite_token
  @invite_link = user_session_url(invite_token: @group_token)
end

def create
  @group = Group.find_by(token: params[:invite_token])
  invite[:session] = @group.id
  if user_signed?
    @group.users << current_user
    invite[:session].clear
    @group.token = nil
  else
  end
end

private
  def generate_invite_token
    SecureRandom.urlsafe_base64(20)
  end
```

### リクエスト承認機能
当初はグループユーザー全員のが承認（どっかのカラムが１になるみたいな）したら承認→実行可能。っていう流れにしようと思ってたけど、リクエスト作成後にグループメンバーに変更がある可能性がある
`group.users.count == どっかのカラムの合計値`みたいにしようと思ってたから後でエラーが起きる可能性がある
リクエスト作成段階で、グループメンバーのうちだれをメンバーにするかを選択してその選択したメンバーの同意が得られれば実行可能って流れになるかな？11月28日現在の案

### 承認機能修正
・申請取り消し時にrequest_usersのapproval_statusも0(unauthorized)に変更するように

・承認、承認取り消しボタンの表示部分について今は
`<% if @request.authorizers_check(current_user) && @subject_authorizer.unauthorized? %>`
みたいになっているがこれに追加で
`admit`には`@request.unauthorized?`
`cancel_admit`には`@request.authorized?`
みたいな記述を追加

・全員に承認されて実行可能になった場合のフラッシュの表示方法を考える