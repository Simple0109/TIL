# コンフリクトとは
この前gitでコンフリクトが起きた。そもそもコンフリクトってなんなのか。よくないものという認識で毎回その場しのぎで解決してたので勉強　　

**コンフリクト(conflict)**
直訳すると「対立」　　
Gitにおいてコミット履歴を2つ以上持つブランチを統合する場合、コンフリクトが起きることがある。　　
例えば2つのブランチをマージする際に両方のブランチで同じ行を編集している場合、コンフリクトが起きる。　　
コンフリクトが発生するとGitは自動的にマージせずに開発者にコンフリクトの解消を求める。　　
コンフリクトが発生した場合、競合の解消、解消後のマージの作業を行う必要がある。　　
## 例
mainブランチから派生したdevelopブランチがあり、そこから派生したfeature/change-btnブランチがあると仮定する  
developブランチとfeature/change-btnブランチ両方で以下のファイルがあると仮定する
```html:sample.txt
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>テストページ</title>
</head>
<body>
    <section>
        <h1>タイトル</h1>
        <p>テキストテキストテキストテキストテキストテキスト</p>
        <button>ボタン</button>
    </section>
</body>
</html>
```
そしてfeature/change-btnブランチでは以下のように変更しコミットする
```html:sample.txt(feature/change-btnブランチ)
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>テストページ</title>
</head>
<body>
    <section>
        <h1>タイトル</h1>
        <p>テキストテキストテキストテキストテキストテキスト</p>
        <button class="feature-btn">ボタン</button> <!--クラス名追加-->
    </section>
</body>
</html>
```
次にdevelopブランチに切り替え以下のように変更しコミットする
```html:sample.txt(developブランチ)
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>テストページ</title>
</head>
<body>
    <section>
        <h1>タイトル</h1>
        <p>テキストテキストテキストテキストテキストテキスト</p>
        <button class="develop-btn">ボタン</button> <!--クラス名追加-->
    </section>
</body>
</html>
```

この段階でdevelopブランチとfeature/change-btnブランチに**同じ行の変更内容が異なる**sample.txtファイルが存在することになる　　
この状態でdevelopブランチで`git merge feature/change-btn`を行いfeature/change-btnブランチの内容をmergeすると同じ行で異なる内容になっているためコンフリクトが起きる　　
Gitはどちらの内容をマージしたらいいかわからない状態になっている　　
ターミナルには以下のように書かれている
```
On branch develop
You have unmerged paths.
(fix conflicts and run “git commit”)
(use “git merge –abort” to abort the merge)

Unmerged paths:
(use “git add <file>…” to mark resolution)
both modified: sample.html

no changes added to commit (use “git add” and/or “git commit -a”)

(日本語訳)
ブランチ開発で
マージされていないパスがあります。
（競合を修正し、「gitcommit」を実行します）
（「gitmerge –abort」を使用してマージを中止します）

マージされていないパス：
（「gitadd <file> …」を使用して解決をマークします）
両方とも変更：sample.html

コミットに変更が追加されていません（「gitadd」および/または「gitcommit-a」を使用)
```
競合している場所を修正してコミットしてね！って書いてる　　
次にsample.txtを見ると以下のように書かれている
```html:sample.txt(develop)
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>テストページ</title>
</head>
<body>
    <section>
        <h1>タイトル</h1>
        <p>テキストテキストテキストテキストテキストテキスト</p>
<<<<<<< HEAD
        <button class="develop-btn">ボタン</button> //クラス名追加
=======
        <button class="feature-btn">ボタン</button>
>>>>>>> feature/change-btn
    </section>
</body>
</html>
```
`<<<<<<`や`>>>>>`という記号が追加されているが以下の意味
```
<<<<<<< HEAD
# developブランチの変更内容（現在のブランチ）

=======
# feature/change-btnブランチの変更内容（取り込まれるブランチ）

>>>>>>> feature/change-btn
```
今回はfeature/change-btnブランチの内容を反映させたいので、以下のように修正  
```html:sample.txt(develop)
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>テストページ</title>
</head>
<body>
    <section>
        <h1>タイトル</h1>
        <p>テキストテキストテキストテキストテキストテキスト</p>
        <button class="feature-btn">ボタン</button>
    </section>
</body>
</html>
```
あとはいつも通りコミットする！

**解消方法**
まずdevelopブランチに移動し`git pull`を実行（developブランチの最新にするため？）　　
次にaブランチに移動して、developブランチに`git merge`する（
## コンフリクトの解消方法
1. `git rebase`

2. `git merge`