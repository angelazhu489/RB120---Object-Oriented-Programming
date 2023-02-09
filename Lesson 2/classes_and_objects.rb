# 1 - Given the below usage of the Person class, code the class 
# definition.

# class Person
# 	attr_accessor :name
# 	def initialize(name)
# 		@name = name
# 	end
# end

# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# bob.name = 'Robert'
# p bob.name                  # => 'Robert'

# 2 - Modify the class definition from above to facilitate the 
# following methods. Note that there is no name= setter method now. 
# Hint: let first_name and last_name be "states" and create an 
# instance method called name that uses those states.

# class Person
# 	attr_accessor :first_name, :last_name
# 	def initialize(full_name)
# 		@first_name = full_name.split[0]
# 		@last_name = full_name.split.size > 1 ? full_name.split[-1] : ''
# 	end

# 	def name
# 		last_name != '' ? "#{first_name} #{last_name}" : first_name
# 	end
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# 3 - Now create a smart name= method that can take just a first 
# name or a full name, and knows how to set the first_name and 
# last_name appropriately.

# class Person
# 	attr_accessor :first_name, :last_name
# 	def initialize(full_name)
# 		parse_name(full_name)
# 	end

# 	def name
# 		last_name != '' ? "#{first_name} #{last_name}" : first_name
# 	end

# 	def name=(name)
# 		parse_name(name)
# 	end

# 	def parse_name(name)
# 		@first_name = name.split[0]
# 		@last_name = name.split.size > 1 ? name.split[-1] : ''
# 	end
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'

# 4 - Using the class definition from step #3, let's create a few 
# more people -- that is, Person objects. If we're trying to 
# determine whether the two objects contain the same name, how can 
# we compare the two objects?

# class Person
# 	attr_accessor :first_name, :last_name
# 	def initialize(full_name)
# 		parse_name(full_name)
# 	end

# 	def name
# 		last_name != '' ? "#{first_name} #{last_name}" : first_name
# 	end

# 	def name=(name)
# 		parse_name(name)
# 	end

# 	def parse_name(name)
# 		@first_name = name.split[0]
# 		@last_name = name.split.size > 1 ? name.split[-1] : ''
# 	end

# 	def same?(other_name)
# 		other_name.name == self.name
# 	end
# end

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')
# p rob.same?(bob)
# # OR
# p rob.name == bob.name

# 5 - Continuing with our Person class definition, what does the 
# below code print out? Let's add a to_s method to the class. Now, 
# what does the below output?

class Person
	attr_accessor :first_name, :last_name
	def initialize(full_name)
		parse_name(full_name)
	end

	def name
		last_name != '' ? "#{first_name} #{last_name}" : first_name
	end

	def name=(name)
		parse_name(name)
	end

	def parse_name(name)
		@first_name = name.split[0]
		@last_name = name.split.size > 1 ? name.split[-1] : ''
	end

	def same?(other_name)
		other_name.name == self.name
	end

	def to_s
		name
	end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
# => The person's name is: #<Person:0x0000000147157eb0> (without
# 		overriding to_s method)