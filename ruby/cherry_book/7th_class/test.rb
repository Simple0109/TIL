# users = []
# users << { first_name: "alice", last_name: "Ruby", age: 20 }
# users << { first_name: "Bob", last_name: "Python", age: 30}
#
# def full_name(user)
#   # "#{user[:first_name]} #{user[:last_name]}"
#   "#{user[:first_name] + " " + user[:last_name]}"
# end
#
# users.each do |user|
#   puts "氏名:#{full_name(user)}、年齢:#{user[:age]}"
# end
#
# class User
#   attr_reader :first_name, :last_name, :age
#
#   def initialize(first_name, last_name, age)
#     @first_name = first_name
#     @last_name = last_name
#     @age = age
#   end
#
#   def full_name
#     "#{self.first_name} #{self.last_name}"
#   end
# end
#
# alice = User.new("Alice", "Ruby", 20)
# bob = User.new("Bob", "Python", 30)
#
# # 同じメソッドを持つが、保持しているデータは異なるので出力が異なる
# puts alice.full_name
# #=> Alice Ruby
#
# puts bob.full_name
# #=> Bob Python
#
# users = []
# users << User.new("Alice", "Ruby", 20)
# users << User.new("Bob", "Python", 30)
#
# users.each do |user|
#   puts "氏名：#{user.full_name} 年齢：#{user.age}"
# end

# class User
#   def hello
#     puts "Hello!"
#   end
# end
#
# user = User.new
# user.hello

# class User
#   def initialize(name)
#     # インスタンス作成時に渡された名前をインスタンス変数に保持する
#     @name = name
#   end
#
#   def hello
#     puts "Hello, I am #{@name}"
#   end
# end
#
# user = User.new("hoge")
# user.hello

# class User
#   def initialize(name)
#     @name = name
#   end
#
#   def name
#     @name
#   end
#
#   def name=(value)
#     @name = value
#   end
# end
# user = User.new("hoge")
# user.name
# user.name = "fuga"
# user.name

# class User
#   attr_accessor :name, :age
#
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end
#
# user = User.new("hoge", 20)
# user.name #=> "hoge"
# user.age #=> 20

# class User
#   def initialize(name)
#     @name = name
#   end
#
#   def self.create_users(names)
#     names.map do |name|
#       User.new(name)
#     end
#   end
#
#   def hello
#     puts "Hello, I am #{@name}"
#   end
# end
#
# names = ["hoge", "fuga", "isikawa"]
# users = User.create_users(names)
# users.each do |user|
#   puts user.hello
# end

#class User
#  attr_accessor :name
#
#  def initialize(name)
#    @name = name
#  end
#
#  def rename_to_bob
#    name = "Bob"
#  end
#
#  def rename_to_carol
#    self.name = "Carol"
#  end
#
#  def rename_to_dave
#    @name = "Dave"
#  end
#end
# user = User.new("hoge")

# class Product
#   attr_reader :name, :price
#
#   def initialize(name, price)
#     @name = name
#     @price = price
#   end
#
#   # 金額を整形するクラスメソッド
#   def self.format_price(price)
#     "#{price}円"
#   end
#
#   def to_s
#     # インスタンスメソッドからクラスメソッドを呼び出す
#     formatted_price = Product.format_price(price)
#     "name: #{name}, price: #{formatted_price}"
#   end
# end
#
# product = Product.new("hoge", 110)
# product.to_s
# #=> "name: hoge, price: 10000円"

# class Product
#   attr_reader :name, :price
#
#   def initialize(name, price)
#     @name = name
#     @price = price
#   end
# end
#
# class DVD < Product
#   # nameとpriceはProduct（スーパークラス）でattr_readerが設定されているので定義不要
#   attr_reader :running_time
#
#   def initialize(name, price, running_time)
#     super(name, price)
#     @running_time = running_time
#   end
# end
#
# dvd = DVD.new("A great movie", 1000, 120)
# p dvd.name
# p dvd.price
# p dvd.running_time

# class Product
#   attr_reader :name, :price
#
#   def initialize(name, price)
#     @name = name
#     @price = price
#   end
#
#   def to_s
#     "name: #{name}, price: #{price}"
#   end
# end
#
# class DVD < Product
#   attr_reader :running_time
#
#   def initialize(name, price, running_time)
#     super(name, price)
#     @running_time = running_time
#   end
#
#   def to_s
#     "#{super}, running_time: #{running_time} "
#   end
# end
#
# product = Product.new("A great movie", 1000)
# puts product.to_s
#
# dvd = DVD.new("An Awesome film", 3000, 120)
# puts dvd.to_s

# class  Product
#   private
#
#   def name
#     "A great movie"
#   end
# end
#
# class DVD < Product
#   public
#
#   def name
#     "An awesome film"
#   end
# end
#
# # nameメソッドはprivateのためエラーが起きる
# product = Product.new
# # puts product.name
# #=> private method `name' called for an instance of Product (NoMethodError)
#
# # DVDクラスではpublicメソッドになっているため呼び出せる
# dvd = DVD.new
# puts dvd.name
# #=> An awesome film

class User
  attr_reader :name

  def initialize(name, weight)
    @name = name
    @weight = weight
  end

  def heavier_than?(other_user)
    other_user.weight < @weight
  end

  protected

  def weight
    @weight
  end
end
