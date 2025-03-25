
# def hoge(x)
#   (1...5).each do |i|
#     x += 1
#   end
#   puts x
# end
# x=0
# hoge(x)

# begin
#   1/0
# rescue
#   pp "0で割ってはだめです!"
# end

# begin
#   1/0
#   rescue StandardError => e
#     puts e
#     puts e.class
#     puts e.class.superclass
#     puts e.message
# end

# begin
#   1/0
# rescue ZeroDivisionError => e
#   puts e.class
#   puts e.message
# end

# def fullname(surname, firstname)
#   "#{surname} #{firstname}"
# end
#
# begin
#   1/3
#   puts fullname("石川")
# rescue ArgumentError, ZeroDivisionError => e
#     puts e.class
#     puts e.message
# end

# begin
#   1/1
# rescue => e
#   puts e
# ensure
#   puts "ensure"
# end

# count = 0
# begin
#   1/0
# rescue
#   p count += 1
#   retry if count < 5
#   puts "無理でした"
# end

# begin
#   raise
#   rescue
#     p "例外です"
# end

# begin
#   raise ZeroDivisionError
# rescue => e
#   p e.class
# end

# def foo(*a)
#   p a
# end
# foo(1,2,3)

# def some_method
#   _local_variable = "これはローカル変数です"
#   puts _local_variable
# end
# some_method

# $global_variable = "これはグローバル変数です"
# def access_global
#   puts $global_variable
#   $global_variable = "変更"
# end
# puts $global_variable
# access_global
# puts $global_variable

# class Person
#   def initialize(name)
#     @name = name
#   end
#
#   def greet
#     puts "こんにちは、#{@name}さん"
#   end
#
#   def change_name(new_name)
#     @name = new_name
#   end
# end
#
# person = Person.new("田中")
# person.greet
# person.change_name("石川")
# person.greet

# class Counter
#   @@count = 0
#
#   def initialize
#     @@count += 1
#   end
#
#   def self.count
#     @@count
#   end
#
#   def report
#     puts "現在のカウント: #{@@count}"
#   end
# end
#
# puts Counter.count
# c1 = Counter.new
# puts Counter.count
# c2 = Counter.new
# puts Counter.count
# c1.report

#class Hoge
#  attr_reader :message
#  def initialize
#    @message = "Hello"
#  end
#end
#
#class Piyo < Hoge
#  def initialize
#    @message = "Hi"
#    super
#  end
#end
#
#puts Piyo.new.message
#
#class User
#  attr_reader :name, :email, :address, :age
#  def initialize(name, email, address, age)
#    @name = name
#    @email = email
#    @address = address
#    @age = age
#  end
#

#  def name
#    @name
#  end
#
#  def email
#    @email
#  end
#
#  def address
#    @address
#  end
#
#  def age
#    @age
#  end
# end

# class Parent
#   def greet(name)
#     puts "Hello, #{name}"
#   end
# end
#
# class Child < Parent
#   def greet(name)
#     puts "こんにちは、最初の挨拶"
#     super("石川")
#     puts "こんにちは、もう一度"
#   end
# end
#
# Child.new.greet("alex")

# def area r
#   return r * r * PI
# end

# s = "Hello"
# def s.greet
#   puts "Hi!"
# end
#
# class String
#   def greet
#     puts "Hello!"
#   end
# end
#
# s.greet

# class Employee
#   attr_reader :id
#   attr_accessor :name
#   def initialize(id, name)
#     @id = id
#     @name = name
#   end
#
#   def to_s
#     return "#{@id}:#{@name}"
#   end
#
#   def <=> other
#     return self.id <=> other.id
#   end
# end
#
# employees = []
# employees << Employee.new("3", "Tanaka")
# employees << Employee.new("1", "Suzuki")
# employees << Employee.new("2", "Sato")
#
# employees.sort!
# employees.each do |employee|
#   puts employee
# end

# a = [1,2,3,4]
# b = [1,3,5,7]
# c = a | b
# c.each { |i| print i, " " }

a = [1,2,3,4]
a[0, 3].each do |i| print i, " " end
