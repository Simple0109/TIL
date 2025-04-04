# # タスクの状態を整数値で管理
# status = :done
#
# case status
# when :todo
#   puts "これからやります"
# when :doing
#   puts "今やってます"
# when :done
#   puts "もう終わりました"
# end

def buy_burger(menu, drink: true, potato: true, **others)
  # しょうりゃく
  puts others
end

buy_burger("fish", drink: true, potato: true, salad: false, chicken: true)
