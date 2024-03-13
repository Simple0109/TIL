def fizz_buzz(end_range)
  (1..end_range).each do |i|
    if i % 15 == 0
      puts "FuzzBuzz"
    elsif i % 5 == 0
      puts "Fuzz"
    elsif i % 3 == 0
      puts "Buzz"
    else
      puts i
    end
  end
end

end_range = ARGV[0].to_i

fizz_buzz(end_range)
