### git stash
`git stash`はGitリポジトリで一時的に変更を退避させるためのコマンド
変更を退避させることで一時的に他のブランチに切り替えたり、別の作業を行うことができる

`git stash`
現在の作業ディレクトリの変更が一時的に退避できる
※g`git stash`では新規に作成したファイルは退避されないため`git stash -u`を実行しなければならない
`-u`は`--include-untracked`の略

`git stash list`
退避した一時的な変更を確認することができる

`git stash apply`
`git stash`で退避した内容を復元する。なお復元したあともstashは消えずに残る

`git stash apply stash@{n}`
特定のstashした変更を復元する。nには数字が入る。nの数字は`git stash list`で確認できる

`git stash drop`
`git stash`で一時的にstackしているデータを削除する
`git stash drop stash@{n}`で特定の内容をstashから削除することができる

`git stash pop`
`git stash apply`と同様に最新のstashした内容を復元するが、復元後、stashから削除される
`git stash pop stash@{0}`で特定の内容をstashから復元し、その後削除する

`git stash branch <branch_name>`
新しいブランチを作成し、そのブランチにstashした変更を復元する。stashした変更は、復元したブランチに適用される。