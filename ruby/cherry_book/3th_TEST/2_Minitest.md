## Minitest
### テストコードの雛形
Minitestは`test_`で始まるメソッドを探して実行するため、メソッド名は`text_`で始めることが必須
```ruby
require "minitest/autorun"

class SampleTest < Minitest::Test
  def test_sample
    assert_equal "RUBY", "ruby".upcase
  end
end
```
`assert_equal "RUBY", "ruby".upcase`が実行結果を確認するための検証メソッド
`assert_equal`メソッドはMinitestが提供しているメソッドで、`"ruby".upcase`の実行結果が`"RUBY"`になることを検証している。
`assert_equal`メソッドは以下のように使用する
`assert_equal 期待する結果, テスト対象となる値や式`

### Minitestの検証メソッド
```ruby
# aとbが等しい場合パス
assert_equal b, a

# aが真のときパス
assert a

# aが偽のときパス
refute a
```

### テストが失敗したときの挙動
```ruby
require "minitest/autorun"

class SampleTest < Minitest::Test
  def test_sample
  # 頭文字だけ大文字にするcapitalizeを使う
    assert_equal "RUBY", "ruby".capitalize 
  end
end
```
```shell
ruby sample_test.rb
Run options: --seed 45917

# Running:
# 失敗
F

Failure:
# SampleTestクラスのtest_sampleメソッド
# sample_test.rbの5行目で失敗
SampleTest#test_sample [sample_test.rb:5]:
# 期待した結果
Expected: "RUBY"
  # 実際の結果
  Actual: "Ruby"

bin/rails test sample_test.rb:4

Finished in 0.000643s, 1555.2099 runs/s, 1555.2099 assertions/s.
1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```

### 実行中にエラーが起きた場合
```ruby
  require "minitest/autorun"

  class SampleTest < Minitest::Test
    def test_sample
      # nilは文字列じゃない（String）じゃないのでupcaseが使えない
      assert_equal "RUBY", nil.upcase
    end
  end
```
```shell
ruby sample_test.rb
Run options: --seed 15111

# Running:
# エラー
E

Error:
SampleTest#test_sample:
# nilにはupcaseメソッドが定義されていないというエラー
NoMethodError: undefined method `upcase' for nil:NilClass
    sample_test.rb:5:in `test_sample'

bin/rails test sample_test.rb:4

Finished in 0.000643s, 1555.2099 runs/s, 0.0000 assertions/s.
1 runs, 0 assertions, 0 failures, 1 errors, 0 skips
```

失敗及びエラーが発生した場合、それ以上そのテストメソッドは処理されない。
続けて実行するテストメソッドがある場合、そのテストメソッドの実行に移る。

### FizzBuzzプログラムのテスト自動化
```ruby
def fizz_buzz(n)
  if n % 15 == 0
    "FizzBuzz"
  elsif
    n % 3 == 0
    "Fizz"
  elsif
    n % 5 == 0
    "Buzz"
  else
    n.to_s
  end
end

require "Minitest/autorun"
class FizzBuzzTest < Minitest::Test
  def test_fizz_buzz
    assert_equal "1", fizz_buzz(1)
    assert_equal "2", fizz_buzz(2)
    assert_equal "Fizz", fizz_buzz(3)
    assert_equal "4", fizz_buzz(4)
    assert_equal "Buzz", fizz_buzz(5)
    assert_equal "Fizz", fizz_buzz(6)
    assert_equal "FizzBuzz", fizz_buzz(15)
  end
end
```