array = [64, 34, 25, 12, 22, 11, 90]
array_length = array.length

def sort_array(a)
  a_length = a.length
  a_length.times do |i|
    (a_length - (i + 1)).times do |j|
      if a[j] > a[j+1]
        escape = a[j]
        a[j] = a[j + 1]
        a[j +1] = escape
      end
    end
  end
  return a
end

p sort_array(array)
