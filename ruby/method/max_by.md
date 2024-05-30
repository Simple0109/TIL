# max_by
各要素に順番にブロックを渡して実行して、その評価結果を比較して、最大であった値に対応する元の要素を返す
```ruby
a = %w(albatross dog horse)
a.max_by
# => #<Enumerator: ["albatross", "dog", "horse"]:max_by>
a.max_by { |x| x.length }
# => "albatross"

a = %w[albatross dog horse]
a.max_by(2)
# => #<Enumerator: ["albatross", "dog", "horse"]:max_by(2)>
a.max_by(2) {|x| x.length }
# => ["albatross", "horse"]
```

```ruby
votes = {"sato"=>1, "suzuki"=>3, "takahashi"=>1}
votes.max_by {|name, count| count}[0]
# => "suzuki"
```
このようにした時ハッシュのkeyを`name`にvalueを`count`に格納し、`count`の数値を比較して最も大きい数値のvalueを持つ`name`を返している　　
仮に`[0]`を除いて`vites.max_by {|name, count| count}`とした場合は`["suzuki", 3]`が返る　　
`[0]`をつけることで要素の一番初めの`name`の値が取れる


