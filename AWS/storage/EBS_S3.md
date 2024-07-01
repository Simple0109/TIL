# EBS
`Elastic Block Storage`の略 
EC2インスタンスにアタッチして使用するブロックストレージ   
※ブロックストレージ：記憶領域をボリュームという単位に分け、ボリュームをさらにブロックという単位に分けてデータを保存するストレージ   
## EBSの特徴
* ボリュームの変更
追加のボリュームが必要になった場合、いつでも追加することができるし、不要なボリュームが発生した場合はいつでも削除することができる  
確保している容量に応じて課金される  
* AZ間でレプリケート
同じAZの複数サーバー間で**自動的にレプリケーションされる**  
これによって高い(99.999%)**可用性を提供**している   
※可用性：システムが停止することなく稼働し続けられる性能   
* ボリュームタイプが変更可能
提供されるボリュームタイプは以下の4つ
1. 汎用SSD(gp2, gp3)
gp2では**IOPS**がボリュームサイズで決定されており変更することができないが、gp3では**IOPS**の設定を行うことができる  
※IOPS:1秒あたりにディスが処理することのできるI/Oアクセス数のこと    
2. プロビジョンドIOPS SSD(io2)
高いIOPS(16000)を選択したい場合に選択する。プロビジョンドIOPS SSDで指定することのできるIOPSの最大値は64000    
3. スループット最適化HDD
SSDほどの性能を必要とせず、コストを節約したい場合選択する。   
4. Cold HDD
スループット最適化HDDよりもアクセス数が少ない場合選択する。   
スループット最適化HDDとCold HDDはルートボリュームとしては選択することができず、追加のボリュームとして使用することができる   
* 高い耐久性のスナップショット
AZでレプリケートされているが、AZ全体で障害が起きてしまった場合、EBSも使用できなくなる可能性がある  
差分のみを保存し容量を抑えることのできる**スナップショット**と呼ばれるデータのバックアップを**S3**にバックアップとして保存することができるため高い耐久性が実現されている  
* ボリュームの暗号化
EBSは設定することで**自動で暗号化**されセキュリティを強化することができる   
暗号化されたボリュームのスナップショットも、自動的に行われる  
なお暗号化はKMS(Key Management Service)を使用しており、暗号化キーの管理はKMSで行う  
* 永続的なストレージ
EBSはEC2インスタンスと異なるハードウェアで管理されているため、インスタンスを停止し、再度開始した場合でもEBSに保存したデータは残っているため 
インスタンスの状態に関わらず永続的にデータが保存されている  

# S3
`Simple Storage Service`の略  
オブジェクトストレージの1つ。リージョンに設置される
※オブジェクトストレージ：**オブジェクト**を最小の単位として取り扱い、**オブジェクト**はそれぞでユニークなIDが付与され、データの属性情報（メタデータ）と一緒に管理される 
## S3の特徴
* 無制限のストレージ容量
**バゲット**というデータの入れ物さえ作れば、すぐにデータを保存し始めることができ、またその容量は無制限(保存する1つのファイルサイズの制限は5TBまで)
* 高い耐久性・可用性
保存されたオブジェクトは1つのリージョン内の複数のAZに自動的に複製される 
これによち1つのAZで障害が発生した場合でも、すぐにオブジェクトをより出すことができるため、高い耐久性と可用性を備えている 
* インターネット経由のアクセス
S3はインターネット経由で世界中のどこからでもアクセスすることができる  

## セキュリティ
S3バケットは作成したアカウントから許可されたユーザーやリソースからのアクセスのみを受け付けるため、必要に応じてアクセス権限を付与する必要がある
### アクセス権限の付与
**IAMユーザー**や**IAMロール(EC2, lambda関数など)**にIAMポリシーをアタッチすることで権限を許可したり、制限することができる 
### ブロックパブリックアクセス
デフォルトでアクセス制限をしている機能
### 通信、保存データを暗号化
S3に保存するデータの暗号化には3つの書類がある   
1. S3のキーを使用したサーバーサイド暗号化(デフォルト)
2. KMSを使用したサーバーサイド、もしくはクライアントサイド暗号化
3. ユーザー独自のキーを使用したサーバーサイド、もしくはクライアントサイド暗号化
## Macie
S3に保存されているデータを自動的にスキャンし、機密情報や個人情報を特定し、分類するセキュリティサービス  
## S3のユースケース
* アプリケーションのデータ保存
S3にアクセスできる権限を設定したIAMポリシーをアタッチしたIAMロールをEC2インスタンスや、lambda関数に設定する 
こうすることでEC2インスタンスにアタッチされたEBSにデータを保存する必要がなくなるため、AutoScallingがしやすくなる  
* HTML,CSS,Javascript,画像、動画ファイルなどの静的コンテンツの配信
静的なコンテンツであればEC2でWebサーバーを準備せずともインターネットに配信できるため、これらのコンテンツをS3バケットに配置すれば良い  
`静的コンテンツ`：サーバーに保存されている任意のファイル。毎回同じものがユーザーに配信される（HTML, 画像ファイル etc...）
* データレイクとしてのデータ保存と分析
S3に保存したJSON、CSV、Parquetなどのテキストデータをそのまま多方面から分析に使用するような構成を**データレイク**と呼ぶ  
分析に使用するのは**Redshift**, **Athena**, **EMR**などのサービスがある   
`Redshift`:列指向形のDWH（データウェアハウス）サービスで大量データの高速分析やレポーティングに使われる  
`Athena`:サーバーレスでインフラストラクチャの管理が不要で複数オブジェクトに対して対話的なSQLクエリを実行できる    
`EMR`:ビッグデータ処理に用いられるOSSのマネージドサービス   
* データバックアップの保存
**バージョニング**機能を有効化することで、オブジェクトの意図しない上書きや削除の対策を行うことができる  
**バージョニング**を有効にすることで、すべてのオブジェクトに**オブジェクトキー**と**バージョンID**が設定される。仮にオブジェクトを上書きや削除をおこなったとしても、過去のオブジェクトは全て残る（削除した場合も最新のオブジェクトは削除マーカーが付けられたうえで、過去のバージョンとして残る）  
このようにすることで過去のバージョンIDを指定すれば、その過去のバージョンのオブジェクトにアクセスすることができる  
* クロスリージョンレプリケーションによる災害対策
S3バケットにはバケット同士のレプリケーションが可能になる機能がある。その中でもリージョンをまたぐレプリケーションを行うことを**クロスリーションレプリケーション**と呼ぶ  
リージョンを跨ぐことで大規模災害対策として運用することができる  

# EBSとS3の違い
最大の違いはストレージの種類  
* EBS:ブロックストレージ
データを**ブロック**という固定された長さの単位に分割して管理する。このブロックには番号が割り振られているため、特定のデータを書き換えたい時はその番号をもとに検索することが可能  
これによってデータへのアクセスが容易になり、処理速度が上がる。  
よって**EBSば特に処理速度を高速化させたいデータの保存に適している**
* S3:オブジェクトストレージ
データを**オブジェクト**単位で保存する。一般的にパソコン等で保存されるファイルストレージとは違い、フォルダの階層などを作らずにフラットに保存する  
これによってデータの移動や分散した保存がしやすくなり、データ量の増加にも対応できるようになる  
よって**S3は耐久性が高く大量のデータを保存しやすい**