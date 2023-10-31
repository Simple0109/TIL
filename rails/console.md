# エラー
### エラーの特定
仮にUserモデルで新規のuserをコンソールで作ろうとして、rollbackやエラーが発生したときに
`$ puts user.errors.full_messages`を実行するとどういったエラーが発生しているか出力してくれる
