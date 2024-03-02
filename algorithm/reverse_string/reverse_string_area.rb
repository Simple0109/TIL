def reverse_string(s, a, b)
  a -= 1
  b -= 1

  s[0...a] + s[a..b].reverse + s[(b+1)..-1]
end

s = "hello,world!"
a = 3
b = 6

puts reverse_string(s, a, b)
