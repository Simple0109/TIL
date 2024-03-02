# require "prime"
# puts Prime.prime?(3)

def prime?(n)
  return false if n < 2
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  return true
end

n = ARGV[0].to_i
puts prime?(n)
