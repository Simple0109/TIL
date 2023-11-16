`<div class="mb-6 grid gap-6 sm:grid-cols-2 md:mb-8 lg:grid-cols-3 lg:gap-8">`
>mb-6
margin-bottomを6に設定し、下方向のマージンを設定
>grid gap-6
グリッドを作成、グリッド内の各要素間のギャップを6に設定
>sm:grid-cols2
スクリーンサイズが小さい(small以上)場合にグリッドの列数を2に設定
>md:md-8
スクリーンサイズが中くらい(medium以上)の場合に下方向のマージンを8に設定
>lg:grid-clos-3
スクリーンサイズが大きい(large以上)場合にグリッドの列数を3に設定
>lg:gap-8
スクリーンサイズが大きい(large以上)場合にグリッド内の各要素間のギャップを8に設定

### font
フォントの太さを制御

### text
フォントの大きさを制御

### flex
`flex` : デフォルトで横方向にflexコンテナを作る（子要素は縦に並ぶ）
`basic-数字` : flexアイテムの初期サイズを設定
`initial` : 小さくはしてもいいが、大きくはしない
`1` : 初期サイズを無視して大小が動く
`auto` : 初期サイズを考慮して大小動く（指定したサイズの比率が動かない感じかな）
`none` : 初期サイズを動かさない
`row` : flexアイテムをテキストと同じ方向に水平に配置
`row-reverse` : flexアイテムをテキストと逆方向に配置
`col` : 上から下に配置
`col-reverse` : 下から上に配置
`grow` : flexアイテムを開いてスペースいっぱいに配置（成長するようにだってオシャレ）
`glow-0` : flexアイテムを成長させないように配置

[参考サイト](https://tech-machi-log.com/tailwindcss-flexbox/)

### overflow
コンテナに大して大きすぎるコンテンツの要素をどのように扱うか制御する
`visible` : はみ出した要素をそのまま可視化する
`hidden` : はみ出した要素をクリッピングする
`auto` : はみ出た要素があればスクロールバーを追加する。ただし常にスクロールバーがでるわでなく、必要な場合のみ
`x-auto` :`auto`の横バージョン
`y-auto` :`x-auto`の縦バージョン


### blockとinlineとinline-block
`block` : 前後に改行が入る（縦に並ぶ）
`inline` : 改行が入らない（横に並ぶ）
`inline-block` : 前の行のみ改行が入る（前の行から改行され、続く行は改行されない）

### padding
`p` : 全方位のpaddingを指定
`pt` : 上方向のpaddingを指定
`pb` : 下方向のpaddingを指定
`pl` : 左方向のpaddingを指定
`pr` : 右方向のpaddingを指定
`px` : 水平方向のpaddingを指定
`py` : 垂直方向のpaddingを指定  
