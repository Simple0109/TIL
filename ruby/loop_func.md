## ループ処理
### for ~ in ~
要素（範囲）の分だけ、繰り返す
```ruby
for num in 1..5 do 
  puts num
end

# 戻り値
1
2
3
4
5
=> 1..5
```

### while
条件が`false`になるまで繰り返す
```ruby
irb(main):008> num = 0
=> 0
irb(main):009* while num <= 12 do
irb(main):010*   p num
irb(main):011*   num += 3
irb(main):012> end
0
3
6
9
12
=> nil
```

### until
条件が`true`になるまで繰り返す
```ruby
irb(main):023> num = 16
=> 16
irb(main):024* until num <= 12 do
irb(main):025*   p num
irb(main):026*   num -= 2
irb(main):027> end
16
14
=> nil
```

### times
指定した回数繰り返す
```ruby
irb(main):034> num = 0
=> 0
irb(main):035* 5.times do
irb(main):036*   p num
irb(main):037> end
0
0
0
0
0
=> 5
```

値を変化させながらループ
```ruby
irb(main):038> num = 0
=> 0
irb(main):039* 5.times do |num|
irb(main):040*   p num
irb(main):041*   num += 1
irb(main):042> end
0
1
2
3
4
=> 5
```

### loop
`break`を使って止めない限り、無限に繰り返す
```ruby
irb(main):043> num = 0
=> 0
irb(main):044* loop do
irb(main):045*   p num
irb(main):046*   num += 1
irb(main):047*   if num >= 3
irb(main):048*     break
irb(main):049*   end
irb(main):050> end
0
1
2
=> nil
```

## ループ処理中のテクニック
### next
スキップする
```ruby
irb(main):051> num = 0..5
=> 0..5
irb(main):052* 6.times do |num|
irb(main):053*   next if num == 1
irb(main):054*   p num
irb(main):055> end
0
2
3
4
5
=> 6
```

### redo
やり直しする
```ruby
irb(main):056> num = 0..5
=> 0..5
irb(main):057* 6.times do |num|
irb(main):058*   num += 1
irb(main):059*   p num
irb(main):060*   redo if num == 1
irb(main):061> end
1
2
2
3
4
5
6
=> 6
```

### break
中断する
```ruby
irb(main):062> num = 0..5
=> 0..5
irb(main):063* 6.times do |num|
irb(main):064*   break if num == 3
irb(main):065*   p num
irb(main):066> end
0
1
2
=> nil
```