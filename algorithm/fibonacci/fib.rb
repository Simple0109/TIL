n = ARGV[0].to_i
def fib(n)
  a = 0
  b = 1
  (n-1).times do
    temp = a
    a = b
    b = temp + a
  end

  puts a
end

fib(n)
