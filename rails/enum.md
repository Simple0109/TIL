# enumとは
1つのカラムに指定した複数個の定数を保存できるようにするもの
```ruby
enum blood_type: {A: 0, B: 1, O: 2, AB: 3 }
```

```shell
User.blood_types
=> { "A"=>0, "B"=>1, "O"=>, "AB"=>3 }

User.find_by(blood_type: "A").blood_type
=> "A"
```

モデルファイルに定義することで定数とinteger型を紐づけることができる
```ruby
class User < ApplicationRecord
  enum blood_type: { A: 0, B: 1, O: 2, AB: 3 }
end
```
※boolean型も定義できるが`false`, `true`であればenumを使わなくてもなのとかなることが多いし
Rails 5.2系で`false`にupdateする際に`null`に更新しようとするとバグが発生しているらしいので
使う必要がない場合は使わなくても良いと思われる

### enumの定数を設定するときに予約語を使わないこと
予約語とはruby言語ややrailsフレームワーク内部で特別な意味を持っていたり、自動的に使用されることがある言葉
enumの定数に予約語を使用するとエラーが起きるので使用しないこと
[参考記事](https://zenn.dev/goldsaya/articles/465c9d5b0de72d)

## メソッド
### 確認メソッド
確認メソッドとは今enumカラムに入っている定数が何か確認することができるメソッド
```ruby
user = User.find_by(name: 'programan')
=> #<User:0x007f82b7b6fe40
  id: 1,
  name: "programan",
  age: 25,
  blood_type: "A",
  is_married: false,
  created_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00,
  updated_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00>

user.blood_type
=> "A"

user.A?
=> true
user.B?
=> false
user.O?
=> false
user.AB?
=> false

user.C?
NoMethodError: undefined method `C?' for #<User:0x007f82b7b6fe40>
```
上記のようにモデルのインスタンスに対して`インスタンス.定数名?`とすることで
enumカラムであるblood_typeに指定した定数が入っていれば`true`が返ってきて、指定した定数が入っていなければ`false`が返る

### 更新メソッド
更新メソッドは今`enumカラム`に入っている定数を別の定数に更新するメソッドのこと
モデルのインスタンスに対して`インスタンス.定数名!`の形で使う
```ruby
user = User.find_by(name: "programan_father")
=> #<User:0x007f82b384d838
  id: 2,
  name: "programan_father",
  age: 58,
  blood_type: "A",
  is_married: true,
  created_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00,
  updated_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00>

user.blood_type
=> "A"

user.B!
UPDATE `users` SET `blood_type` = 1, `updated_at` = '2020-01-29 03:41:33' WHERE `users`.`id` = 2
=> true

user.blood_type
=> "B"

user.A!
UPDATE `users` SET `blood_type` = 0, `updated_at` = '2020-01-29 03:42:40' WHERE `users`.`id` = 2
=> true

user.blood_type
=> "A"

user.C!
NoMethodError: undefined method `C?' for #<User:0x007f82b7b6fe40>
```

### 検索メソッド
検索メソッドは`enumカラム`のデータを検索する検索メソッド
モデルクラスに対して`モデルクラス.定数名`の形で使用する
```ruby
a_type_users = User.A

SELECT `users`.* FROM `users` WHERE `users`.`blood_type` = 0

=> [#<User:0x007f82b50f12e0 
  id: 1, 
  name: "programan", 
  age: 25, 
  blood_type: "A", 
  is_married: false, 
  created_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00, 
  updated_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00>,

 #<User:0x007f82b50f11a0 
  id: 2,
  name: "programan_father",
  age: 58,
  blood_type: "A",
  is_married: true,
  created_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00,
  updated_at: Wed, 29 Jan 2020 03:42:40 UTC +00:00>,

 #<User:0x007f82b50f1060 
  id: 6,
  name: "programan_bigbrother",
  age: 28, 
  blood_type: "A",
  is_married: true,
  created_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00,
  updated_at: Wed, 29 Jan 2020 01:44:45 UTC +00:00>
]
```