### format
`validates :hoge, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }`
のように正規表現と一致するかを検証
※`/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i`はメールアドレス検証の正規表現