# devise
ログイン認証機能(ログイン、ログアウト機能)等を簡単に実装できるGem
その他にも[公式](https://github.com/heartcombo/devise)にかかれているように様々な機能がある
Database Authntucatable: サインイン時にユーザーの真正性を検証するために、パスワードをハッシュ化してデータベースに保存します。認証は POST リクエストや HTTP ベーシック認証の両方で行うことができます。
Omniauthable: OmniAuth (https://github.com/omniauth/omniauth) サポートを追加します。
Confirmable：確認の指示メールを送信し、サインイン時にアカウントが確認済みかどうかを検証します。
Recoverable：ユーザーパスワードをリセットし、リセットの指示を送信します。
Registerable（登録可能）：登録プロセスを通じてユーザーを登録し、アカウントの編集と破棄を可能にします。
Rememberable: 保存されたクッキーからユーザーを記憶するためのトークンの生成とクリアを管理します。
Trackable：サインイン数、タイムスタンプ、IPアドレスを追跡します。
Timeoutable（タイムアウト可能）: 指定された期間にアクティブでなかったセッションを失効させます。
Validatable: メールとパスワードのバリデーションを提供します。これはオプションであり、カスタマイズすることができますので、独自のバリデーションを定義することができます。
Lockable：サインインに失敗した回数が指定された場合、アカウントをロックします。電子メールまたは指定された期間後にロックを解除できます。

## 使い方
Gemfileに記述
```
gem "devise"
```
ターミナルで`$ rails g devise:install`を実行

通常モデルを作成するときには`$ rails g model名 ~ `を実行するが認証が使えるモデルを作成するときには`$ rails g devise model名`を実行する
このコマンドでモデルを作成するとログイン認証するためのファイルが自動で作成され、認証機能が使えるようになる
仮に`Userモデル`を作成するときには`$ rails g devise user`でを実行すればおk
これを実行すると`route.rb`に`devise_for :users`自動で追記される
この記述によってサインアップやログインなどの認証のためのルーティングが自動で作成される
**devise_for**
deviseのヘルパーメソッド
`:モデル名`を指定すると認証に必要なルーティングを自動で設定してくれる。この記述の追加と同時にマイグレーションファイルも作成される

### カラムを追加して、そのカラムを認証機能で使用する場合
自動で作成されたマイグレーションファイルの内容をみると`name`カラムについての記述がないため、`name`カラム等を追加したい場合、追記してから`$ rails db:migrate`すること
また追加したカラムを認証機能で使用する場合、追加したカラムをsign up時に変更許可する設定を行う必要がある
[認証カラムの追加について](https://github.com/heartcombo/devise#strong-parameters)

deviseのコントローラはライブラリで用意されているため直接変更ができないのでapplication_controllerに以下の記述を行う
```ruby
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  #以下の:name部分は追加したカラムに変える
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
```
`before_action :configure_permitted_parameters, if: :devise_controller?`
if文の条件(devise_controllerが呼び出されたら)を満たした時、実行前にconfigure_permitted_parametersアクションを実行

`devise_parameter_sanitizer.permit(:deviseの処理名, key: [:許可するカラム])`
`devise_parameter_sanitizer` -> sanitizerメソッドはUserモデルのパラメーター（情報）を取得するメソッド
`permit(:sign_up, key: [:name])` -> sign_up時にnameデータの操作を許可

**deviseの処理**
>There are just three actions in Devise that allow any set of parameters to be passed down to the model, therefore requiring sanitization. Their names and default permitted parameters are:
Deviseには3つのアクションがあり、どのようなパラメータのセットでもモデルに渡すことができるため、サニタイズが必要です。それらの名前とデフォルトで許可されるパラメータは以下の通りです：
>・sign_in (Devise::SessionsController#create) - Permits only the authentication keys (like email)
sign_in (Devise::SessionsController#create) - 認証キー（メールアドレスなど）のみを許可します。
>・sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password and password_confirmation
sign_up (Devise::RegistrationsController#create) - 認証キーとパスワード、password_confirmation を許可します。
>・account_update (Devise::RegistrationsController#update) - Permits authentication keys plus password, password_confirmation and current_password
account_update (Devise::RegistrationsController#update) - 認証キーとパスワード、password_confirmation、current_password の入力を許可する

上記をまとめるとdeviseコントローラが呼び出され時、nameの変更を許可する。といった内容

### ヘルパーメソッド
**`before_action:authenticate_user!`**
アクセス権限の設定をする。ログイン後のみアクセスできるページを作りたいときに設定する
viewでif文を使い、画面遷移のためのボタンをログインしていない場合には表示しないように設定すればいいように思えるが、この方法だとURLを直接入力すると画面遷移することができるので`before_action :authenticate_user!`をコントローに記述する必要がある
onlyで特定のアクションのみに設定したり、exceptで特定のアクションを除外することもできる

**`user_signed_in?`**
ユーザーがログインしているかどうか判定する
ユーザーがログインしていれば`true`が、ログアウトしていれば`false`が返される
ログイン時と非ログイン時でヘッダーの表示を変更する際にif文の条件として使用したりする

**`current_user`**
現在ログインしているユーザーをモデルオブジェクトとして利用できる
簡単に現在のユーザーのID等を取得できるため非常に便利(`current_user.id`)

**`user_session`**
ユーザーのセッション情報を設定・取得するためのメソッド