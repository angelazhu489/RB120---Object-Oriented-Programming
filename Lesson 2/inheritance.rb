# 1 - One problem is that we need to keep track of different 
# breeds of dogs, since they have slightly different behaviors. For 
# example, bulldogs can't swim, but all other dogs can. Create a 
# sub-class from Dog called Bulldog overriding the swim method to 
# return "can't swim!"
class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
	def speak
    'bark!'
  end

	def swim
    'swimming!'
  end

	def fetch
    'fetching!'
  end
end

class Bulldog < Dog
	def swim
		"can't swim!"
	end
end

# 2 - Create a new class called Cat, which can do everything a dog 
# can, except swim or fetch. Assume the methods do the exact same 
# thing. Hint: don't just copy and paste all methods in Dog into 
# Cat; try to come up with some class hierarchy.
class Cat < Pet
	def speak
    'meow!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

karl = Bulldog.new
puts karl.speak           # => "bark!"
puts karl.swim            # => "can't swim!"

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
# pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
# p kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"

# 3 - Draw a class hierarchy diagram of the classes from step #2
=begin
Pet (run, jump) -> Dog (speak, swim, fetch) -> Bulldog (swim)
								-> Cat (speak)
=end

# 4 - What is the method lookup path and how is it important?
=begin
Order in which Ruby will traverse the class hierarchy to look 
for methods to invoke.
Eg. Bulldog.ancestors = Bulldog, Dog, Pet, Object, Kernel, BasicObject
=end
p Bulldog.ancestors