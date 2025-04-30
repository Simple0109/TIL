# Time
[class Time](https://docs.ruby-lang.org/ja/latest/class/Time.html)
時刻を表すクラス

`Time.now`は現在時刻を返す
```ruby
irb(main):004> Time.now
=> 2025-04-30 15:34:31.803521 +0900
```
指定した時刻から年月日などの情報を取得できる
```ruby
irb(main):007> time = Time.now
=> 2025-04-30 15:36:15.773129 +0900
irb(main):008> time.year
=> 2025
irb(main):009> time.month
=> 4
irb(main):010> time.day
=> 30
irb(main):011> time.hour
=> 15
irb(main):012> time.min
=> 36
irb(main):013> time.sec
=> 15

# timeの年の1月1日から何日経過したか
irb(main):016> time.yday
=> 120

# タイムゾーンの確認
irb(main):017> time.zone
=> "JST"
```

### 秒単位で時間の加減が可能
```ruby
irb(main):022> time1 = Time.local(2016,7,5,12,00,00)
=> 2016-07-05 12:00:00 +0900
irb(main):023> time2 = Time.now
=> 2025-04-30 15:40:05.651189 +0900

# time1に13秒追加
irb(main):024> time1 + 13
=> 2016-07-05 12:00:13 +0900

# time1に3日追加
irb(main):025> time1 + 24*60*60*3
=> 2016-07-08 12:00:00 +0900

# time1の3日前
irb(main):026> time1 - 24*60*60*3
=> 2016-07-02 12:00:00 +0900

# 指定日時の差分を秒数
irb(main):027> time2 - time1
=> 278307605.65118897

# 秒数を日数に変換
irb(main):028> (time2 - time1) / (24*60*60)
=> 3221.1528431850575
```

### 比較も可能
```ruby
irb(main):022> time1 = Time.local(2016,7,5,12,00,00)
=> 2016-07-05 12:00:00 +0900
irb(main):023> time2 = Time.now
=> 2025-04-30 15:40:05.651189 +0900

irb(main):032> time1 > time2
=> false
irb(main):033> time2 > time1
=> true
```

### 文字列を変換することも可能
Rubyでは時間だと判断できるものを自動的にTimeオブジェクトに変換する`parse`というメソッドがある
```ruby
irb(main):039> require "time"
=> true
irb(main):040> Time.parse("2017/4/21 20:13")
=> 2017-04-21 20:13:00 +0900
irb(main):041> Time.parse("4/21 20:13")
=> 2025-04-21 20:13:00 +0900
irb(main):042> Time.parse("2017-4-21")
=> 2017-04-21 00:00:00 +0900
irb(main):043> Time.parse("11:00")
=> 2025-04-30 11:00:00 +0900
```