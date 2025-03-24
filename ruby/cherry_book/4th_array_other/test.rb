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

numbers = []
(1..10).step(2).each { |n| numbers << n }
pp numbers


