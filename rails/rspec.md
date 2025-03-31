# RSpec
[RSpec公式](https://rspec.info/)
テストを実行するためのテストフレームワーク
`gem "rspec-rails"`を追加 -> `bundle install`実行
```shell
rails g rspec:install

# 以下が生成される
#=> create  .rspec
#=> create  spec
#=> create  spec/spec_helper.rb
#=> create  spec/rails_helper.rb
```
を実行し、RSpecをインストール
1. .rspec
テストディスクリプションを表示させる追記ができる
```ruby:.rspec
# spec/spec_helper.rbをテスト実行の度に読み込むための記述
--require spec_helper

# テストディスクリプションを表示させる
--format documentation
```

2. spec/spec_helper.rb
あんまりいじらない（いじったことない）

3. spec/rails_helper
FactoryBotのシンタックスをサポートさせる記述を追記できる

## let
ローカル変数、インスタンス変数を置き換えることができる。
```ruby
RSpec.describe User do
  describe "$greet" do
    let(:user) { User.new(**params) }
    let(:params) { name: "いしかわ" }
    context "12歳以下の場合" do
      before do
        params.merge!(age:12)
        it "ひらがなで答えること" do
          expect(user.greet).to eq "ぼくはいしかわだよ" 
        end
      end
    end

    context "13歳以上のとき" do
      before do
        params.merge!(age:13)
      end
      it "漢字で答えること" do
        expect(user.greet).to eq "僕はいしかわです"
      end
    end
  end
end
```
`let`は遅延評価され、呼び出されたタイミングで実行される
`let!`は即時評価される

## matcher（マッチャ）
期待値と実際の値を比較して、一致した（もしくは一致しなかった）という結果を返すオブジェクト

### to, not_to, to_not
```ruby
# ~であること
expect(1+2).to eq 3
# ~でないこと
expect(1+2).not_to eq 1
expect(1+2).to_not eq 1
```
## be_xxx(predicateマッチャ)
`empty?`のようにメソッド名が「?」で終わり、戻り値が真偽値（`true, false`）になるメソッドを`be_empty`のような形で検証できる
```ruby
# 以下のコードの意味は同じ
expect([]).to be_empty
expect([].empty?).to be true
expect([].empty?).to eq true
```
- be_nil
- be_empty

## have_http_status
https://rspec.info/features/6-0/rspec-rails/matchers/have-http-status-matcher/
https://www.rubydoc.info/gems/rspec-rails/RSpec%2FRails%2FMatchers:have_http_status
コントローラースペックやリクエストスペックでシンボリックかステータスコードの検証ができる
```ruby
describe 'POST /api/v1/signup' do
  context 'with valid params' do
    it 'creates a new user' do
      expect {
        post '/api/v1/signup', params: valid_attributes
      }.to change(User, :count).by(1)
    end

    it 'returns status code 201' do
      post '/api/v1/signup', params: valid_attributes
      expect(response).to have_http_status(:created)
    end
    
    it 'returns user details with token' do
      post '/api/v1/signup', params: valid_attributes
      expect(json['token']).not_to be_nil
      expect(json['user']['email']).to eq(valid_attributes[:email])
    end
  end
end
```

## 配列orハッシュor文字列 + include
配列orハッシュor文字列に〜が含まれているかどうかを検証できる
```ruby
context 'with invalid params' do
  before { post '/api/v1/signup', params: invalid_attributes }
  
  it 'returns status code 422' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
  
  it 'returns validation errors' do
    expect(json['errors']).to include("Password is too short (minimum is 6 characters)")
    expect(json['errors']).to include("Password confirmation doesn't match Password")
  end
end
```

## change + from/to/by
```ruby
# popメソッドを呼ぶと配列の要素が減少することをテストする
x = [1, 2, 3]
expect(x.size).to eq 3
x.pop
expect(x.size).to eq 2
```
上記のコードを以下のように修正できる
```ruby
x = [1, 2, 3]
expect{ x.pop }.to change{ x.size }.from(3).to(2)
```
`expect{ x.pop }.to`のように丸括弧ではなく、中括弧（ブロック）をexpectに渡していること
以下のように読み替えることができる
`expect{ X }.to change{ Y }.from(A).to(B) ＝ 「X すると Y が A から B に変わることを期待する」`