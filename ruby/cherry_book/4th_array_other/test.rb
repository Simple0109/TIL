# numbers = [1,2,3,4,5]
# new_numbers = []
# numbers.each { |n| new_numbers << n * 10 }
# pp new_numbers

# numbers = [1,2,3,4,5]
# new_numbers = numbers.map { |n| n * 10 }
# puts new_numbers

#numbers = [1,2,3,4,5,6]
#even_numbers = numbers.select { |n| n.even? }
#pp even_numbers #=> [2,4,6]

# numbers = [1,2,3,4,5,6]
# # 3の倍数を除外する
# non_multiples_of_three = numbers.reject { |n| n % 3 == 0 }
# pp non_multiples_of_three

# numbers = [1,2,3,4]
# pp numbers.sum(10)

# numbers = [1,2,3,4]
# pp numbers.sum { |n| n * 10 }

#  chars = ["a", "b", "c"]
#  pp chars.sum("")
#  pp chars.join
#  pp chars.join("-")

# pp ["ruby", "java", "javascript"].map { |s| s.upcase }
# pp ["ruby", "java", "javascript"].map(&:upcase)
# pp [1,2,3,4,5,6].select { |n| n.odd? }
# pp [1,2,3,4,5,6].select(&:odd?)

# range = 1..5
# pp range.include?(1)
# pp range.include?(2)
# pp range.include?(5)

# range = 1...5
# pp range.include?(1)
# pp range.include?(4)
# pp range.include?(5)

# a = [1,2,3,4,5]
# pp a[1..3]
#
# s = "abcde"
# pp s[1..4]

# def liquid?(tem)
#   0 <= tem && tem < 100
# end
# pp liquid?(101)

# def liquid?(tem)
#   (0...100).include?(tem)
# end
# pp liquid?(100)

# def charge(age)
#   case age
#   when 0..5
#     0
#   when 6..12
#     300
#   when 13..18
#     600
#   else
#     1000
#   end
# end
# pp charge(19)

# numbers = (1..4).to_a
# sum = 0
# numbers.each { |n| sum += n }
# pp sum

# sum = 0
# (1..4).each { |n| sum += n }
# pp sum

# numbers = []
# (1..10).step(2).each { |n| numbers << n }
# pp numbers

# jp = ["japan", "日本"]
# country = "japan"
# case country
# when *jp
#   "こんにちは"
# end

# def greet(*names)
#   "#{names.join("と")}、こんにちは"
# end
#
# pp greet("石川", "砂糖", "高橋")

# def foo(a, *b, c, d)
#   "a=#{a}, b=#{b}, c=#{c}, d=#{d}"
# end
# pp foo(1,2,3,4,5,6,7)

# number = [10, 20, 30, 40, 50]
# # 3番目以降の要素を取得
# pp number[2..]
# pp number[..1]

# sum = 0
# # 処理を5回繰り返す
# 5.times { |n| sum += n }
# pp sum

# fruits = ["apple", "melon", "orange"]
# numbers = [1,2,3]
# catch :done do
#   fruits.each do |f|
#     numbers.each do |n|
#       puts "#{f}, #{n}"
#       if f == "orange" && n == 3
#         throw :done
#       end
#     end
#   end
# end

# ret =
#   catch :done do
#     throw :done, 123
#   end
# pp ret

# numbers = [1,2,3,4,5]
# numbers.each do |n|
#   next if n.even?
#   puts n
# end

foods = ["ピーマン", "トマト", "セロリ"]
count = 0
foods.each do |food|
  print "#{food}は好きですか？ => "
  answer = "いいえ"
  puts answer

  count += 1
  redo if answer != "はい" && count < 2

  count = 0
end
