### 実装の流れ
```
1. WebSocketサーバーの設定 (ActionCableの使用):
ActionCableの設定: app/channelsに新しいChannelを作成します。例えばRequestChannelという名前で作成すると、app/channels/request_channel.rbになります。このChannelは、特定の@requestのチャットに対応します。
2. チャットメッセージを保存するモデルの作成:
ChatMessageモデルの生成: ChatMessageモデルを生成し、user_id、request_id、contentフィールドを持たせます。これにより、メッセージを保存して、どのリクエストに対するものか、誰が送信したかを追跡できます。
3. フロントエンドの設定 (Stimulusの使用):
Stimulusコントローラーの作成: chat_controller.jsなどのStimulusコントローラーを作成し、チャットフォームの送信を処理し、ActionCableを通じてメッセージを送信します。
4. esbuildの設定:
esbuildの設定: JavaScriptファイルをバンドルするために、esbuildを設定します。Rails 7では、esbuildがデフォルトでサポートされています。
5. チャットUIの作成:
チャットUIの作成: @requestに関連するチャットページに、メッセージを表示するエリアとメッセージを送信するフォームを作成します。
6. チャット参加者の確認:
参加者の確認: RequestChannelで、@request.user_idがcurrent_user.idと一致するか、またはrequest_usersテーブルにcurrent_user.idと@request.idが一致するレコードがあるかどうかを確認します。
7. メッセージのブロードキャスト:
メッセージのブロードキャスト: RequestChannelを通じて、新しいメッセージを@requestに関連する全ユーザーにブロードキャストします。
8. メッセージの受信と表示:
メッセージの受信: Stimulusコントローラーで、ActionCableを通じてメッセージを受信し、チャットエリアにメッセージを動的に追加します。

```

### 初心者向けの解説
```
WebSocketとは: リアルタイム通信を可能にする技術です。通常のHTTPリクエストとは異なり、サーバーとブラウザ間で常時接続を保ち、即座に情報をやり取りできます。

ActionCableとは: Railsが提供するWebSocketのフレームワークです。チャンネルという概念を使って、特定のトピック（この場合は特定の@requestのチャット）に関する通信を管理します。

Stimulusとは: フロントエンドの動作（例えば、フォームの送信やメッセージの表示）を管理するためのJavaScriptフレームワークです。HTMLと簡単に統合できます。

esbuildとは: JavaScriptやCSSなどのファイルを効率的にバンドル（一つにまとめる）し、ブラウザが読み込める形式に変換するツールです。

このプロセスには、サーバーサイド（Ruby on Rails）とクライアントサイド（JavaScript/Stimulus）の両方の作業が含まれます。各ステップを一つ一つ丁寧に進め、必要な機能を実装していきまし
```

### 比較的楽にできそうな方法
[Rails: StimulusReflexとCableReadyでチャット機能を作ってみる](https://qiita.com/kskinaba/items/e6480f0204a453db1ffe)