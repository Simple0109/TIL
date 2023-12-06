### fields_forヘルパー
[Railsガイド](https://railsguides.jp/form_helpers.html#fields-for%E3%83%98%E3%83%AB%E3%83%91%E3%83%BC)
親モデルに紐づいた子モデルのデータを編集するときに使用する
同じフォームで別モデルのオブジェクトのフィールドをレンダリングするときに便利
`accepts_nested_attributes_for`と組み合わせて使用することで親オブジェクトのフォーム送信時に関連オブジェクトの属性も同時に保存可能
今回想定
・親モデル：request
・子モデル：give
まずはモデルの関連付け
give.rb
```ruby
class Give < ApplicationRecord
  belongs_to :request
end
```

request.rb
```ruby
class Request < ApplicationRecord
  has_many :gives, class_name: "Give", dependent: :destroy
  accepts_nested_attributes_for :gives, limit: 3
end
```
※なんか`has_many :gives`じゃアソシエーションが特定できないってエラー吐かれたので`class_name: "Give"`を追加している
`accepts_nested_attribute_for`
ActiveRecordモデルで関連んする別モデルの属性をネスト形式で保存できるようする機能
親モデルのフォームから子モデルのフォームを一緒に送信しアソシエーションを介して子モデルの作成、更新ができる
オプションがある
`allow_destroy: true`:親モデルのフォームで子モデルの削除を可能にする。
`reject_if: :all_blank`:空の子モデルを自動的に拒否する。子モデルの属性が全て空の場合はその子モデルは作成されない
`limit: 1`:親モデルが受け入れる子モデルの最大数を制限できる