# Route53
**エッジロケーション**で使用されるDNS(ドメインネームシステム)サービス   
## 様々なルーティング機能
ルーティング機能には主に下記の3つがある   
* シンプルルーティング
問い合わせに対して、単一のIPアドレス情報を回答するシンプルなルーティング
* レイテンシーベースのルーティング
1つのドメインに対して複数のDNSレコードを用意しておき、地理的な場所を近くして、レイテンシが低くなるようにルーティングを行う
* 加重ルーティング
1つのドメインに対して複数のDNSレコードを用意しておき、割合を決める。その割合に対して回答を返す  
[【AWS初学者向け・図解】Route53ルーティングポリシーを現役エンジニアがわかりやすく解説](https://o2mamiblog.com/aws-route53-routingpolicy-beginner/#:~:text=%E5%8A%A0%E9%87%8D%E3%83%AB%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC%E3%81%AF%E3%80%81%E4%BA%88%E3%82%81,%E3%81%AA%E3%81%93%E3%81%A8%E3%81%8C%E3%81%A7%E3%81%8D%E3%81%BE%E3%81%99%E3%80%82)
[Amazon Route 53のルーティングがすごすぎる件](https://zenn.dev/seyama/articles/02118b0914183e)