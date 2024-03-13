arr = [64, 34, 25, 12, 22, 11, 90]
arr_length = arr.length

arr_length.times do |i|
  (arr_length - (i+1)).times do |j|
    p j
    if arr[j] > arr[j+1]
      es = arr[j]
      arr[j] = arr[j + 1]
      arr[j+1] = es
    end
  end
end

p arr
