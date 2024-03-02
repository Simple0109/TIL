def left_shift_array(a, k)
  k.times do
    element = a.shift
    a.push(element)
  end
  return a
end

array = [1,2,3,4,5]

k = 2

p left_shift_array(array, k)
