## 主要なテクノロジー
・Ruby on Rails
・tailwindcss(daisyUI)
・stimulus
・devise
・omniauth-line
・image_processing
・delayed_job_active_record
・heroku

### Ruby on Rails
私はプログラミングスクールRUNTEQに昨年4月に入学し、主にRubyとRuby on Railsについての学習をしていました。
そのためもっともスムーズにポートフォリオの開発を行える言語とフレームワークがRubyとRuby on Railsだったためこの2つをバックエンドとして採用しています

### tailwindcss(daisyUI)
tailwindcssはレスポンシブデザインの実装や、カスタマイズする際も容易に実装できるため選びました。
またインターネット上に多くの技術記事があり、実装の際も情報を集めやすいと考え採用しました

### DaisyUI
tailwindcssを採用したことから、コンポーネントが豊富で使い回すことが容易なDaisyUIを採用しました

### stimulus
stimulusはRailsと相性のいいフレームワークであり、学習コストが低く、サーバーサイドの開発に重きを置きつつ、比較的リッチなフロントエンドを実現できると考え採用しました

### heroku
私はまだデプロイ回数が多くなく、デプロイ時にエラーが起きることが予想されたため、エラーに遭遇した際も、技術記事や、使用ユーザーの多いHerokuであれば早く解決できると考えHerokuをデプロイ先に採用しました。
またデータベースについてもheroku addonで使用することができるPostgreSQLを採用しました。

### devise
対抗としてsorceryがありましたが、Githubのstar数はdeviseが圧倒的に多く、技術記事の量も多いためdeviseを採用しました。
またユーザー登録の手間を省くためにLINEログイン機能の実装を行いたいと考えていたので、deviseのomniauthableモジュールを使用して外部認証サービスの実装ができると考えdeviseを採用しました。

### image_processing
画像処理に関してはそこまで複雑な処理は行っていないため、より容易にActiveStorageと組み合わせて画像処理機能を実装するために採用しました

### delayed_job
グループの招待リンクを作成後、そのリンクが使用されなかった場合、削除するための
バックグラウンド処理を実装するため、delayed_jobを採用しています

### rubocop

### actioncable

### git(github)
