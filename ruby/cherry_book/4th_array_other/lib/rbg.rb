# def to_hex(r, g, b)
#   "#" +
#     r.to_s(16).rjust(2, "0") +
#     g.to_s(16).rjust(2, "0") +
#     b.to_s(16).rjust(2, "0")
# end

# def to_hex(r,g,b)
#   hex = "#"
#   [r,g,b].each do |n|
#     hex += n.to_s(16).rjust(2, "0")
#   end
#   hex
# end

def to_hex(r,g,b)
  [r,g,b].sum("#") do |n|
    n.to_s(16).rjust(2, "0")
  end
end

# def to_ints(hex)
#   r = hex[1..2]
#   g = hex[3..4]
#   b = hex[5..6]
#   ints = []
#   [r,g,b].each do |s|
#     ints << s.hex
#   end
#   ints
# end

# def to_ints(hex)
#   r = hex[1..2]
#   g = hex[3..4]
#   b = hex[5..6]
#   [r,g,b].map  do |s|
#     s.hex
#   end
# end
# # mapメソッドは戻り値を配列の要素にして新しい配列を返すため上記でOK

# def to_ints(hex)
#   r, g, b = hex[1..2], hex[3..4], hex[5..6]
#   [r, g, b].map do |s|
#     s.hex
#   end
# end

# def to_ints(hex)
#   r, g, b = hex.scan(/\w\w/)
#   [r, g, b].map do |s|
#     s.hex
#   end
# end


def to_ints(hex)
  hex.scan(/\w\w/).map(&:hex)
end
