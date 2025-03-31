### オーバーライドが不可能な演算子
```
?:（三項演算子）
=（代入）
&&, ||, and, or, not（論理）
defined?（定義） 
.., ...（範囲）
```

### 標準ライブラリ
Rubyのコアには含まれていないが、Rubyといっしょにインストールされる標準ライブラリは`require`が必要！
```ruby
require "json"
require "net/http"
require "csv"
require "data"
require "time"
```

### 組み込みクラスやモジュール
Rubyの基本的な機能（組み込みライブラリ）は自動的に利用可能
`require`必要なし！
```ruby
String
Array
Hash
Integer
Float
Kernel
Enumerable
```

### 