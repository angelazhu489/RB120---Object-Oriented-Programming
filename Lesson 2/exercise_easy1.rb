=begin
BANNER CLASS - Complete this class so that the test cases shown 
below work as intended. You are free to add any methods or instance 
variables you need. However, do not make the implementation details 
public. You may assume that the input will always fit in your 
terminal window.
=end
class Banner
  def initialize(message)
		@message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
		"+#{"-" * (@message.size + 2)}+"
  end

  def empty_line
		"| #{" " * @message.size} |"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

=begin
WHATS THE OUTPUT - What output does this code print? Fix this class 
so that there are no surprises waiting in store for the unsuspecting 
developer.
=end
# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     "My name is #{@name.upcase}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

=begin
FIX THE PROGRAM: BOOKS 1 - Complete this program so that it produces 
the expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end
# class Book
# 	attr_accessor :author, :title
#   def initialize(author, title)
#     @author = author
#     @title = title
#   end

#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new("Neil Stephenson", "Snow Crash")
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

=begin
FIX THE PROGRAM: BOOKS 2 - Complete this program so that it produces 
the expected output:
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end
class Book
	attr_accessor :author, :title
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin
FIX THE PROGRAM: PERSONS - Complete this program so that it produces 
the expected output:
John Doe
Jane Smith
=end
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

	def first_name=(name)
		@first_name = name.capitalize
	end

	def last_name=(name)
		@last_name = name.capitalize
	end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

=begin
FIX THE PROGRAM: FLIGHT DATA - There is nothing technically incorrect 
about this class, but the definition may lead to problems in the 
future. How can this class be fixed to be resistant to future problems?
=end
class Flight
  # attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# The problem with this definition is that we are providing easy access 
# to the @database_handle instance variable, which is almost certainly 
# just an implementation detail. As an implementation detail, users of 
# this class should have no need for it, so we should not be providing 
# direct access to it.

=begin
BUGGY CODE: CAR MILEAGE - Fix the following code so it works properly:
=end
# class Car
#   attr_accessor :mileage

#   def initialize
#     @mileage = 0
#   end

#   def increment_mileage(miles)
#     total = mileage + miles
#     self.mileage = total
#   end

#   def print_mileage
#     puts mileage
#   end
# end

# car = Car.new
# car.mileage = 5000
# car.increment_mileage(678)
# car.print_mileage  # should print 5678

=begin
RECTANGLES AND SQUARES - Write a class called Square that inherits 
from Rectangle, and is used like this:
=end
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
	def initialize(size)
		super(size, size)
	end
end

square = Square.new(5)
puts "area of square = #{square.area}"

=begin
COMPLETE THE PROGRAM: CATS! - Update this code so that when you run 
it, you see the following output:
My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.
=end
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
	def initialize(name, age, color)
		super(name, age)
		@color = color
	end

	def to_s
		"My cat #{@name} is #{@age} years old and has #{@color} fur."
	end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

=begin
REFACTORING VEHICLES - Refactor these classes so they all use a common 
superclass, and inherit behavior as needed.
class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end
=end
class Vehicle 
	attr_reader :make, :model

	def initialize(make, model)
		@make = make
		@model = model
	end

	def to_s
		"#{make} #{model}"
	end
end

class Car < Vehicle
	def wheels; 4 end
end

class Motorcycle < Vehicle
	def wheels; 2 end
end

class Truck < Vehicle
	attr_reader :payload
	def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

	def wheels; 6 end
end