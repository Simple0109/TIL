### each_with_index
eachループで回してそれぞれの番号にインデックスを当てられる
```
[array].each_with_index do |item, i|
  "#{i}番目のデータは、#{item}です"
end
```

回し始める回数を指定することもできるため、fruitという変数に配列が格納されていて、10番目から結果を出力したい場合
```
fruit.each_with_index(10) do |item, i|
  "#{i}番目のフルーツは"#{item}です"
end
```
と使うこともできる。