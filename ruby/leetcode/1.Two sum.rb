# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  dict = {}
  nums.each_with_index do |item, i|
    if dict[target - item]
      return dict[target - item], i
    end
    dict[item] = 1
  end
end
