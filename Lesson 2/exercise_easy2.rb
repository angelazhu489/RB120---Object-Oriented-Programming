=begin
FIX THE PROGRAM: MAILABLE - Correct the following program so it will 
work properly. Assume that the Customer and Employee classes have 
complete implementations; just make the smallest possible change 
to ensure that objects of both types have access to the print_address 
method.
=end
require 'pry'

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
	include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
	include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address

=begin
FIX THE PROGRAM: DRIVABLE - Correct the following program so it will 
work properly. Assume that the Car class has a complete 
implementation; just make the smallest possible change to ensure 
that cars have access to the drive method.
=end
module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
# Methods in mixin modules should be defined without using self. in 
# the definition. If you add self. to the definition, the including 
# class will only be able to access the method by calling Drivable.drive; 
# furthermore, the method will not be available at all as an instance 
# method to objects.

=begin
COMPLETE THE PROGRAM: HOUSE - Modify the House class so that the 
above program will work. You are permitted to define only one new 
method in House.
=end
class House
	include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

	def <=>(other)
		price <=> other.price
	end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

=begin
REVERSE ENGINEERING - Write a class that will display:
ABC
xyz
when the following code is run:
=end
class Transform
	attr_accessor :str

	def initialize(str)
		@str = str
	end

	def uppercase
		str.upcase
	end

	def self.lowercase(str)
		str.downcase
	end
end

my_data = Transform.new('abc')
puts my_data.uppercase # => ABC
puts Transform.lowercase('XYZ') # => xyz

=begin
WHAT WILL THIS DO? - What will the following code print?
=end
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
# => ByeBye
puts thing.dupdata 
# => HelloHello

=begin
COMPARING WALLETS - Modify this code so it works. Do not make the 
amount in the wallet accessible to any method that isn't part of 
the Wallet class.
=end
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

	protected 
	attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

=begin
PET SHELTER - Write the classes and methods that will be necessary 
to make this code run, and print the following output:
P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
=end
class Shelter
	attr_accessor :adoptions
	def initialize
		@adoptions = {}
	end

	def adopt(owner, pet)
		if adoptions[owner] == nil
			adoptions[owner] = [pet]
		else
			adoptions[owner] << pet
		end
		owner.adopts_pet
	end

	def print_adoptions
		@adoptions.each do |owner, pets|
			puts "#{owner.name} has adopted the folling pets:"
			pets.each do |pet|
				puts "a #{pet.type} named #{pet.name}"
			end
		end
	end
end

class Owner
	attr_accessor :name, :number_of_pets
	def initialize(name)
		@name = name
		@number_of_pets = 0
	end

	def adopts_pet
		@number_of_pets += 1
	end
end

class Pet
	attr_accessor :type, :name
	def initialize(type, name)
		@type = type
		@name = name
	end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

=begin
MOVING - You need to modify the code so that this works:
You are only allowed to write one new method to do this.
=end
module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
	include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
	include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
	include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

=begin
NOBILITY - Now that we have a Walkable module, we are given a new 
challenge. Apparently some of our users are nobility, and the regular
way of walking simply isn't good enough. Nobility need to strut.
We need a new class Noble that shows the title and name when walk 
is called:
We must have access to both name and title because they are needed 
for other purposes that we aren't showing here.
=end
class Noble
	include Walkable
	attr_reader :name, :title
	def initialize(name, title)
    @name = name
		@title = title
  end

	def walk
    print "#{title} "
		super
  end

	private

  def gait
    "struts"
  end
end


byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

byron.name
# => "Byron"
byron.title
# => "Lord"