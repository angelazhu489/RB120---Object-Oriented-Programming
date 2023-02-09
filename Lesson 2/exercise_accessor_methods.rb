=begin
READING AND WRITING - Add the appropriate accessor methods to the 
following code.
=end
# class Person
# 	attr_accessor :name
# end

# person1 = Person.new
# person1.name = 'Jessica'
# puts person1.name

=begin
CHOOSE THE RIGHT METHOD - Add the appropriate accessor methods to 
the following code.
=end
# class Person
# 	attr_accessor :name
# 	attr_writer :phone_number
# end

# person1 = Person.new
# person1.name = 'Jessica'
# person1.phone_number = '0123456789'
# puts person1.name

=begin
ACCESS DENIED - Modify the following code so that the value of 
@phone_number can still be read, but cannot be 
changed.
=end
# class Person
#   attr_reader :phone_number

#   def initialize(number)
#     @phone_number = number
#   end
# end

# person1 = Person.new(1234567899)
# puts person1.phone_number

# person1.phone_number = 9987654321
# puts person1.phone_number

=begin
COMPARING NAMES - Using the following code, add the appropriate 
accessor methods. Keep in mind that the last_name getter shouldn't 
be visible outside the class, while the first_name getter should 
be visible outside the class.
=end
# class Person
# 	attr_writer :first_name, :last_name
# 	attr_reader :first_name

#   def first_equals_last?
#     first_name == last_name
#   end

# 	private
# 	attr_reader :last_name
# end

# person1 = Person.new
# person1.first_name = 'Dave'
# person1.last_name = 'Smith'
# puts person1.first_equals_last? # false

=begin
WHO IS OLDER? - Using the following code, add the appropriate 
accessor methods. Keep in mind that @age should only be visible 
to instances of Person.
=end
# class Person
# 	attr_writer :age

#   def older_than?(other)
#     age > other.age
#   end

# 	protected
# 	attr_reader :age
# end

# person1 = Person.new
# person1.age = 17

# person2 = Person.new
# person2.age = 26

# puts person1.older_than?(person2) # false
# When a method is protected, instances of the class or a subclass 
# can also call the method

=begin
GUARANTEED FORMATTING - Using the following code, add the 
appropriate accessor methods so that @name is capitalized upon 
assignment.
=end
# class Person
# 	attr_reader :name
	
# 	def name=(n)
# 		@name = n.capitalize
# 	end
# end

# person1 = Person.new
# person1.name = 'eLiZaBeTh'
# puts person1.name

=begin
PREFIX THE NAME - Using the following code, add the appropriate 
accessor methods so that @name is returned with the added prefix 'Mr.'.
=end
# class Person
# 	attr_writer :name

# 	def name
# 		'Mr. ' + @name
# 	end
# end

# person1 = Person.new
# person1.name = 'James'
# puts person1.name

=begin
AVOID MUTATION - The following code is flawed. It currently allows 
@name to be modified from outside the method via a destructive 
method call. Fix the code so that it returns a copy of @name 
instead of a reference to it.
=end
# class Person
#   def initialize(name)
#     @name = name
#   end

# 	def name
# 		@name.clone
# 	end
# end

# person1 = Person.new('James')
# person1.name.reverse!
# puts person1.name #James

=begin
CALCULATED AGE - Using the following code, multiply @age by 2 
upon assignment, then multiply @age by 2 again when @age is returned 
by the getter method.
=end
class Person
	def age=(a)
		@age = a * 2
	end

	def age
		@age * 2
	end
end

person1 = Person.new
person1.age = 20
puts person1.age

=begin
UNEXPECTED CHANGE - Modify the following code to accept a string 
containing a first and last name. The name should be split into 
two instance variables in the setter method, then joined in the 
getter method to form a full name.
=end
class Person
	def name=(n)
		@first_name, @last_name = n.split
	end

	def name
		@first_name + ' ' + @last_name
	end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name