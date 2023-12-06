### kaminariの使い方
Gemfileに`gem "kaminari"`を追加し`bundle install`
その後コンソールで`rails g kaminari:config`を実行することで`kaminari`の設定ファイルが生成される
```ruby
# pageメソッドを使った基本形
def index
  # per()の部分は1ページあたり表示する量を指定。gコマンドで生成されたconfigでも指定可能なので、ここで指定しなくても良い
  @users = User.page(params[:page]).per(10)
end
```
そしてビューファイルに
```ruby
<%= paginate @users %>
```
でページネーションが生成される

### kaminariを配列オブジェクトに使用する場合
pageメソッドを配列に対して使用する場合は`Kaminari::paginate_array`を使用する
```ruby
users = User.all
users_array = users.map do |user|
  user.name
end

@users = Kaminari.paginate_array(users_array).page(params[:page]).per(10)

#もしくは

users = User.all
users_array = users.map(&:title)

@users = Kaminari.paginate_array(users_array).page(params[:page]).per(10)
```

`Kaminari.paginate_array`を使用した場合、内容が配列になるため`orderメソッド`が使えない
その場合`sort_byメソッド`を使用して、一度配列の順序を変更し、格納してから表示させる
```ruby
sorted_requests = all_requests.select { |request| (request.status == "draft") && (request.own?(current_user)) }.sort_by(&:updated_at).reverse
```

### 1つのページに複数のページネーションを使用する場合
各ページネーションがどのparamsを受け取るか指定してやらなければいけない
よって
```ruby
  def index
    all_requests = Request.where(group_id: params[:group_id])
    @draft_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "draft") && (request.own?(current_user)) }).page(params[:draft_page])
    @unauthorized_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "unauthorized") && (request.authorizers_check(current_user) || request.own?(current_user))}).page(params[:unauthorized_page])
    @authorized_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "authorized") && (request.authorizers_check(current_user) || request.own?(current_user))}).page(params[:authorized_page])
    @possible_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "possible")}).page(params[:possible_page])

    @group = Group.find(params[:group_id])
  end
```
このように`pageメソッド`を使う時に`.page(params[:draft_page]`と取得するparamsを指定する
そしてビューファイルで
```ruby
<%= paginate @draft_requests, param_name: "draft_page" %>
```
と受け取るparamを指定する
**paramsではなくparamなことに注意!**