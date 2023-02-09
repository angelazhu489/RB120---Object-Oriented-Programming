# Create a class called MyCar. When you initialize a new instance or 
# object of the class, allow the user to define some instance variables 
# that tell us the year, color, and model of the car. Create an instance 
# variable that is set to 0 during instantiation of the object to track 
# the current speed of the car as well. Create instance methods that 
# allow the car to speed up, brake, and shut the car off.

# Add an accessor method to your MyCar class to change and view the 
# color of your car. Then add an accessor method that allows you to 
# view, but not modify, the year of your car.

# You want to create a nice interface that allows you to accurately 
# describe the action you want your program to perform. Create a method 
# called spray_paint that can be called on an object and will modify 
# the color of the car.


# Create a module that you can mix in to ONE of your subclasses 
# that describes a behavior unique to that subclass.
module Towable
	def can_tow?(pounds)
    pounds < 2000
  end
end

# Create a superclass called Vehicle for your MyCar class to inherit 
# from and move the behavior that isn't specific to the MyCar class 
# to the superclass
class Vehicle
	# Add a class variable to your superclass that can keep track of 
	# the number of objects created that inherit from the superclass
	attr_accessor :color
  attr_reader :model, :year
	@@number_of_vehicles = 0

	# Create a method to print out the value of @@number_of_vehicles
	def self.number_of_vehicles
		puts "This program has created #{@@number_of_vehicles} vehicles"
	end

	def self.gas_mileage(gallons, miles)
		puts "#{miles / gallons} miles per gallon of gas"
	end

	# Move all of the methods from the MyCar class that also pertain 
	# to the MyTruck class into the Vehicle class.
	def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @speed = 0
    @@number_of_vehicles += 1
  end

	def speed_up(num)
		@speed += num
		puts "You push the gas and accelerate #{num} mph."
	end 
	
	def brake(num)
		@speed -= num
		puts "You push the brake and decelerate #{num} mph."
	end

	def current_speed
    puts "You are now going #{@speed} mph."
  end

  def shut_down
    @speed = 0
    puts "Let's park this bad boy!"
  end

	def spray_paint(c)
		self.color = c
		puts "Your new #{color} paint job looks great!"
	end

	# Write a method called age that calls a private method to 
	# calculate the age of the vehicle. Make sure the private 
	# method is not available from outside of the class.
	def age
		puts "Your #{model} is #{years_old} years old."
	end

	private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
	# Create a constant in your MyCar class that stores information 
	# about the vehicle that makes it different from other types of 
	# Vehicles.
	NUMBER_OF_DOORS = 4

	def to_s
		"My car is a #{color}, #{year}, #{model}!"
	end
end

# Create a new class called MyTruck that inherits from your 
# superclass that also has a constant defined that separates it 
# from the MyCar class in some way.
class MyTruck < Vehicle
	include Towable

  NUMBER_OF_DOORS = 2

	def to_s
    "My truck  is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

class Student
	def initialize(name, grade)
		@name = name
		@grade = grade
	end

	def better_grade_than?(other_name)
		grade > other_name.grade
	end

	protected

	attr_reader :grade
	# OR
	# def grade
  #   @grade
  # end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
lumina.current_speed

lumina.color = 'black'
puts lumina.color
puts lumina.year
lumina.spray_paint('red')

MyCar.gas_mileage(13, 351)  # => "27 miles per gallon of gas"

my_car = MyCar.new("2010", "Ford Focus", "silver")
puts my_car  # => My car is a silver, 2010, Ford Focus.

# Print to the screen your method lookup for the classes that you 
# have created.
puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors

puts lumina.age   #=> "Your chevy lumina is 17 years old"

joe = Student.new('Joe', 80)
bob = Student.new('Bob', 50)
puts "Well done!" if joe.better_grade_than?(bob)

# --------------------------------------------------------------------

# class Person
#   attr_accessor :name
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Steve")
# bob.name = "Bob"

# --------------------------------------------------------------------


class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new

p whiskers == ginger

class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end

p Thing.ancestors

class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak



class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end

	def change_grade(new_grade)
		grade = new_grade
	end
end

priya = Student.new("Priya")
priya.change_grade('A')
p priya.grade # => "A"

class MeMyselfAndI
  p "#{self} !"

  def self.me
    p "#{self} !!"
  end

  def myself
    p "#{self} !!!"
  end
end

i = MeMyselfAndI.new
p i
MeMyselfAndI.me
i.myself