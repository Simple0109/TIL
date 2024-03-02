def fib_sum_odd(n)
  a = 0
  b = 1
  sum = 0
  (n-1).times do
    temp = a
    a = b
    b = temp + a
    sum += a if a.odd?
  end

  puts sum
end

n = ARGV[0].to_i
fib_sum_odd(n)
