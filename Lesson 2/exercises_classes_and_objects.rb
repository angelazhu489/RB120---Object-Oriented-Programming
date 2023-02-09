=begin
FIND THE CLASS - Update the following code so that, instead of 
printing the values, each statement prints the name of the class 
to which it belongs.
=end
# puts "Hello".class
# puts 5.class
# puts [1, 2, 3].class
# # => String, Integer, Array

# --------------------------------------------------------------------

=begin
CREATE THE CLASS - Create an empty class named Cat.
=end

# WALK THE CAT - Using the following code, create a module named 
# Walkable that contains a method named #walk. This method should 
# print Let's go for a walk! when invoked. Include Walkable in Cat 
# and invoke #walk on kitty.
# module Walkable
# 	def walk
# 		puts "Let's go for a walk!"
# 	end
# end

# class Cat
# 	include Walkable
# 	# READER - Using the code from the previous exercise, add a getter 
# 	# method named #name and invoke it in place of @name in #greet.
# 	# WRITER - Using the code from the previous exercise, add a setter 
# 	# method named #name=. Then, rename kitty to 'Luna' and invoke 
# 	#greet again.
# 	attr_accessor :name

# 	# WHAT ARE YOU - Using the code from the previous exercise, add an 
# 	# initialize method that prints I'm a cat! when a new Cat object 
# 	# is instantiated.
# 	# HELLO, SOPHIE! I - Using the code from the previous exercise, 
# 	# add a parameter to #initialize that provides a name for the Cat 
# 	# object. Use an instance variable to print a greeting with the 
# 	# provided name. (You can remove the code that displays I'm a cat!.)
# 	def initialize(name)
# 		@name = name
# 	end

# 	# HELLO, SOPHIE! II - Using the code from the previous exercise, 
# 	# move the greeting from the #initialize method to an instance 
# 	# method named #greet that prints a greeting when invoked.
# 	def greet
# 		puts "Hello! My name is #{name}!"
# 	end
# end


# # CRATE THE OBJECT - Using the code from the previous exercise, 
# # create an instance of Cat and assign it to a variable named kitty.
# kitty = Cat.new('Sophie')
# kitty.greet
# kitty.name = 'Luna'
# kitty.greet
# kitty.walk

# --------------------------------------------------------------------

=begin
GENERIC GREETING 1 - Modify the following code so that Hello! I'm 
a cat! is printed when Cat.generic_greeting is invoked.
=end
# class Cat
# 	def self.generic_greeting
# 		puts "Hello! I'm a cat!"
# 	end
# end

# Cat.generic_greeting

=begin
HELLO, CHLOE! - Using the following code, add an instance method 
named #rename that renames kitty when invoked.
=end
# class Cat
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

# 	def rename(name)
# 		self.name = name
# 	end
# end

# kitty = Cat.new('Sophie')
# p kitty.name
# kitty.rename('Chloe')
# p kitty.name

=begin
IDENTIFY YOURSELF 1 - Using the following code, add a method named 
#identify that returns its calling object.
=end
# class Cat
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

# 	def identify
# 		self
# 	end
# end

# kitty = Cat.new('Sophie')
# p kitty.identify

# GENERIC GREETING 2 - Using the following code, add two methods: 
# ::generic_greeting and #personal_greeting. The first method should 
# be a class method and print a greeting that's generic to the 
# class. The second method should be an instance method and print 
# a greeting that's custom to the object.
# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

# 	def self.generic_greeting
# 		puts "This is in the Cat class"
# 	end

# 	def personal_greeting
# 		puts "This is #{name}"
# 	end
# end

# kitty = Cat.new('Sophie')
# Cat.generic_greeting
# kitty.personal_greeting

=begin
COUNTING CATS - Using the following code, create a class named Cat 
that tracks the number of times a new Cat object is instantiated. 
The total number of Cat instances should be printed when ::total 
is invoked.
=end
# class Cat
# 	@@num_cats = 0

# 	def initialize
# 		@@num_cats += 1
# 	end

# 	def self.total
# 		p @@num_cats
# 	end
# end

# kitty1 = Cat.new
# kitty2 = Cat.new

# Cat.total

=begin
COLORFUL CAT - Using the following code, create a class named Cat 
that prints a greeting when #greet is invoked. The greeting should 
include the name and color of the cat. Use a constant to define 
the color.
=end
# class Cat
# 	COLOR = 'purple'

# 	attr_accessor :name
	
# 	def initialize(name)
# 		@name = name
# 	end

# 	def greet
# 		puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
# 	end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

=begin
IDENTIFY YOURSELF 2 - Update the following code so that it prints 
I'm Sophie! when it invokes puts kitty.
=end
# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

# 	def to_s
# 		"I'm #{name}"
# 	end
# end

# kitty = Cat.new('Sophie')
# puts kitty

=begin
PUBLIC SECRET - Using the following code, create a class named Person 
with an instance variable named @secret. Use a setter method to add 
a value to @secret, then use a getter method to print @secret.
=end
# class Person
# 	attr_accessor :secret
# end

# person1 = Person.new
# person1.secret = 'Shh.. this is a secret!'
# puts person1.secret

=begin
PRIVATE SECRET - Using the following code, add a method named 
share_secret that prints the value of @secret when invoked.
=end
class Person
  attr_writer :secret

	def share_secret
		p secret
	end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

=begin
PROTECTED SECRET - Using the following code, add an instance
method named compare_secret that compares the value of @secret 
from person1 with the value of @secret from person2.
=end
class Person
  attr_writer :secret

	def compare_secret(other_secret)
		secret == other_secret
	end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)