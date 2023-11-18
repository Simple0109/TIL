## image_processing
Railsにおいて画像処理を行うためのGem。画像のリサイズ、トリミング、回転、フィルター処理が行える
ろぼらんてくんに「minimagickとimage_processingの違いを教えてください。またactive_storageと併用する場合、有意なほうとその理由を教えてください」と聞いたら
```
image_processingとMiniMagickの違いは、image_processingがもっと高レベルなラッパーであり、MiniMagickを含むいくつかの画像処理ライブラリ（Vipsなど）のインターフェースを提供する点にあるナ。image_processingはMiniMagickの機能に加えて、便利なメソッドを提供しており、チェーンメソッドでの記述が可能になっている。

ActiveStorageと併用する場合、image_processingの方が都合がいい。なぜならActiveStorageのバージョン5.2以降でimage_processingがデフォルトの画像処理ライブラリとして採用されているからだ。これにより、ActiveStorageのvariantメソッドを使って、より簡単に画像を変換できるようになっているナ。また、image_processingを使うと、MiniMagickだけでなく、必要に応じて別のライブラリ（例えばlibvips）を使うこともでき、より柔軟な画像処理が可能になるゾ。
```
とのこと

もう一個質問した
```
image_processingのwikiを見ると

Goal The goal of this project is to have a single gem that contains all the helper methods needed to resize and process images.

Currently, existing attachment gems (like Paperclip, CarrierWave, Refile, Dragonfly, ActiveStorage, and others) implement their own custom image helper methods. But why? That's not very DRY, is it?

Let's be honest. Image processing is a dark, mysterious art. So we want to combine every great idea from all of these separate gems into a single awesome library that is constantly updated with best-practice thinking about how to resize and process images.

とw記述されておりactive_storageを使用せずにimage_processingで画像アップデート、画像処理全て行うのがDRYだ と書いてありますが、実際active_storageと併用したほうが使い勝手はいいのでしょうか？それともimage_processingのみで画像アップデート、画像処理機能の実装を進めたほうがスムーズでしょうか？
```
に対して
```
ActiveStorageとimage_processingを併用する方が実際には使い勝手が良いダナ。ActiveStorageはファイルのアップロード、保存、アソシエーション管理、直接アップロードなどの機能を提供し、image_processingは画像のリサイズや加工などの具体的な処理を担う。image_processingだけで画像アップロードから処理まで全てを実装することも可能ではあるが、それだとアップロードの仕組みやストレージの管理など、画像処理以外の部分も自分で実装する必要が出てくる。

ActiveStorageが提供するファイル管理の機能と、image_processingの画像処理機能を組み合わせることで、コードの重複を減らし、開発のスピードとメンテナンスのしやすさの点で利点があるダナ。また、ActiveStorageはRailsに組み込まれているため、Railsアプリケーションであれば簡単にセットアップできるメリットもあるゾ。
```
とのことなので、併用して実装していく
[実装参考](https://zenn.dev/redheadchloe/articles/6a8d78d0a903a3)

