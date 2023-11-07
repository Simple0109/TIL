### エラーの特定
仮にUserモデルで新規のuserをコンソールで作ろうとして、rollbackやエラーが発生したときに
`$ puts user.errors.full_messages`を実行するとどういったエラーが発生しているか出力してくれる

### アソシエーションの確認
コンソールで`モデル名.reflect_on_all_associations`を実行することで
モデル名に入力したモデルの全てのアソシエーションを確認することができる
