
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

# a = [1,2,3,4]
# a[0, 3].each do |i| print i, " " end

# a = [1,2,3]
# b = [4,7]
# c = [8,9,10,11,12]
# p a.zip(b, c)

# a=[1,2,3,4,5]
# p a.slice(0)
# p a.slice(0, 2)
# p a.slice(0..3)
# p a.slice(0, 10)
# p a.slice(10, 1)

# s = <<"EOB"
# Hello,
# Ruby,
# World.
# EOB
# "EOB"
# puts s

# doq = <<EOS
# 最近
#
# 四季の移り変わりが
# 曖昧で
#
# 風邪ひきやすいですよね
# EOS
# puts doq

# s1 = "Hoge"
# s2 = "Fuga"
# s1.concat(s2)
# s1.chop
# s1.chomp
# s1 + s2
# puts s1

# member = ["Ishikawa", 10]
# print "ID:%2d, Name:%s" % member

# h = {"a": 0, "b": 1, "c": 2, "d": 3,}
# p h.invert

#h = {"a": 0, "b": 1, "c": 2, "d": 3}
# h = {"a" => 0, "b" => 1, "c" => 2}
# p h.has_key?("a")

# ファイルデータの内容
# abcdefg

# File.open("data") do |io|
#   while not io.eof?
#     print io.read(1)
#     io.seek(0, IO::SEEK_SET)
#   end
# end

# t = Time.gm(1970, 1, 1)
# puts t.strftime(" %Y/%m/%d" )

# y = true
# y && (raise "failed")
# puts("succeeded!")

# str = "ruby ruby ruby"
# puts str.sub(/ruby/, "java")

# class Parent
#   attr_reader :name
#   def initialize(name)
#     @name = name
#   end
# end
#
# class Child < Parent
#   def initialize(name)
#     @name = "Child"+name
#   end
# end
#
# s = Child.new("石川")
# puts s.name

# a = [1,2,3,4]
# b = [1,3,5,7]
# p a || b

# a=[0,1,2,3,4,5]
# a.delete_if{ |x| x % 2 == 0}
# p a

# a = [:a, :a, :b, :c]
# a[]

# a = {"Foo"=>"Hoge", "Bar"=>"Piyo", "Baz"=>"Fuga"}
# b = {"Foo"=>"hoge", "Bar"=>"piyo", "Baz"=>"fuga"}
#
# p a.update(b).sort{|a,b| a[1] <=> b[1]}

# t = Time.local(2000,1,1)
# print(t.strftime("%Y/%m/%d"))


def age_message(age)
  case
  when age < 18
    puts "あなたは未成年です"
  when age < 20
    puts "あなたは成人ですがお酒は20歳からです"
  else
    puts "あなたは成人です"
  end
end

age_message(23)
