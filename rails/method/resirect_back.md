### redirect_back
リクエストを送った直前のページに遷移する
ページに遷移できない場合の処理を追記する場合は
```ruby
  def set_selected_group
    session[:selected_group_id] = params[:group_id]
    redirect_back(fallback_location: root_path)
  end
```
とすることで遷移できない場合`root_path`に遷移する

