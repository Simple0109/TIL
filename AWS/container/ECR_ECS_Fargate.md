# ECR
`Elastic container registry`の略  
コンテナレジストリのマネージドサービス。サーバーの管理やアベイラリティゾーンを意識することなく**リージョン**で使用できる
コンテナイメージを保存するリポジトリを**レジストリ**と呼ぶ。

## ECSとは
`Elastic container Service`の略 
AWSでDockerコンテナのデプロイや管理運営を行うための、フルマネージドなコンテナオーケストレーションサービス   
※オーケストレーションサービス：コンピュータシステムやソフトウェア、サービスの構築における、設定、管理、調整の「自動化」の意味   
ECS自体はコンテナの実行環境ではなく、あくまでコンテナが正常に稼働するサポートをするサービス   
ECSで実行されるコンテナを**タスク**と呼ぶ   
ユーザーはEC2インスタンスをプロビジョニングして、クラスターとして管理する   
※クラスター：実行環境やIAM権限の境界線。クラスターの中には複数のコンテナが格納されている。  

### なぜコンテナオーケストレーションサービスを使用するのか
コンテナは「1コンテナに1プロセスだけを起動させる」というベストプラクティスがある。しかしその場合、ホストOSでなんらかの障害が起きてしまった場合、その影響がその中で動作しているコンテナ全体に行き渡る    
コンテナオーケストレーションを使用し、本番環境でコンテナを動かす場合、一部のコンテナが停止しても提供しているサービスが停止しないように、可用性や冗長性を考慮して複数コンテナを複数サーバーに分散させておくことが安全  
しかし、複数のコンテナの管理、運営を行うこと自体が今度は大変になってしまう  
そんなときにコンテナオーケストレーションサービスを使用することで、複数のコンテナの運用を自動化することができる    

## Fargate
AWSのコンテナサービスはコンテナを管理する**コントロールプレーン**と、コンテナを動かすための実行環境である**データプレーン**の2つで構成されている
ECSはコントールプレーンの1つ   
データプレーンには2種類ある  
* EC2
インスタンスを管理する必要がある。インスタンスを柔軟に設定/調整することができる
* **Fargate**
サーバーレスコンテナ実行環境で**インスタンスの管理が不要**→管理者はインスタンスの管理から解放される 

# まとめ
複数のECRに複数のDockerイメージを保存   
それらの管理を行うためにオーケストレーションサービスであるECSを使用することで、管理運用を自動化することができる   
ECSを実行するための環境はEC2もしくはFargate   
EC2であればインスタンスの管理をしなければならないが、その分細やかな調整をすることも可能   
Fargateであればサーバーレスコンテナ実行環境のため、EC2は不要となりメンテナンスやスケーリングをする必要がなくなる  
そしてこれらのコンテナ群のことをECSを用いてオーケストレーションしている場合、タスクと呼ぶ