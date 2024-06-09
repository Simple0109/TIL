# Shoulda Matchers
RSpec内で使用できるライブラリ。複雑なテストを一行で書くことができるマッチャを提供する。　　
https://github.com/thoughtbot/shoulda-matchers

model specを記述する際にアソシエーションのテストの記述を容易にできないか調べていると発見  
仮に`Group`モデルと`User`モデルとその中間テーブル`group_users`が存在し以下のようなアソシエーションを設定しているとする
```ruby
# Userモデル
has_many :group_users, dependent: :destroy
has_many :groups, throuth: :group_users

# Groupモデル
has_many :group_users, dependent: :destroy
has_many :users, :throuth: :group_users

# group_userモデル
belongs_to :user
belongs_to :group
```
このGroupモデルのアソシエーションテストを`Shoulda Matchers`を使わないで記述するとすると以下のようになる
```ruby
describe 'アソシエーションのテスト' do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  # groupとuserがletで定義したgroupとuserになるようにgroup_userを定義する
  let(:group_user) { create(:group_user, group: group, user: user) }

  it 'group_userに関連づいたgroupが存在するか、dependent: :destroyが正常か' do
    group_user
    expect(group.group_users).to include(group_user)
    # groupを削除したとき、関連付けられているgroup_userが削除されて、GroupUserテーブルが1つ減っているかを検証
    expect(group.destroy).to change { GroupUser.count }.by(-1)
  end
end
```
`Shoulda Matchers`を使うと以下のようになる
```ruby
  describe 'アソシエーションのテスト' do
    it { should have_many(:group_users).dependent(:destroy) }
  end
```
このようにかなり短く同じ内容のテストを書くことができる  
この他にもバリデーションテストの際にも使用することでかなりテストコードを短くできる。　　
が今回バリデーションのテストは使わずに書いて学習することにした。　　
