require 'pry'
=begin
PRIVACY - Modify this class so both flip_switch and the setter method 
switch= are private methods.
=end
class Machine
  def start
    flip_switch(:on)     # self.flip_switch(:on) is okay in Ruby 2.7 or higher
  end

  def stop
    flip_switch(:off)    # self.flip_switch(:off) is okay in Ruby 2.7 or higher
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

=begin
FIXED ARRAY - A fixed-length array is an array that always has a 
fixed number of elements. Write a class that implements a fixed-length 
array, and provides the necessary methods to support the following code:
=end
class FixedArray

	# def initialize(size)
	# 	@array = Array.new(size)
	# end

	# def [](ind)
	# 	if ind < array.size
	# 		array[ind]
	# 	else
	# 		raise IndexError
	# 	end
	# end
	
	# def []=(ind, num)
	# 	if ind < array.size
	# 		array[ind] = num
	# 	else
	# 		raise IndexError
	# 	end
	# end

	# def to_a
	# 	array
	# end

	# def to_s
	# 	array.to_s
	# end

	private
	attr_accessor :array
end


class FixedArray
  def initialize(max_size)
    @array = Array.new(max_size)
  end

  def [](index)
    @array.fetch(index)
  end

  def []=(index, value)
    self[index]             # raise error if index is invalid!
    @array[index] = value
  end

  def to_a
    @array.clone
  end

  def to_s
    to_a.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

=begin
STUDENTS - Below we have 3 classes: Student, Graduate, and 
Undergraduate. The implementation details for the #initialize 
methods in Graduate and Undergraduate are missing. Fill in those 
missing details so that the following requirements are fulfilled:

Graduate students have the option to use on-campus parking, while 
Undergraduate students do not.

Graduate and Undergraduate students both have a name and year 
associated with them.
=end
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
		super(name, year)
		@parking = false
  end
end

class Undergraduate < Student
  def initialize(name, year)
		super
  end
end

=begin
CIRCULAR QUEUE - A circular queue is a collection of objects stored 
in a buffer that is treated as though it is connected end-to-end in 
a circle. When an object is added to this circular queue, it is 
added to the position that immediately follows the most recently 
added object, while removing an object always removes the object 
that has been in the queue the longest.

This works as long as there are empty spots in the buffer. If the 
buffer becomes full, adding a new object to the queue requires 
getting rid of an existing object; with a circular queue, the object 
that has been in the queue the longest is discarded and replaced by 
the new object.

Assuming we have a circular queue with room for 3 objects, the 
circular queue looks and acts like this:
Your task is to write a CircularQueue class that implements a 
circular queue for arbitrary objects. The class should obtain the 
buffer size with an argument provided to CircularQueue::new, and 
should provide the following methods:

- enqueue to add an object to the queue
- dequeue to remove (and return) the oldest object in the queue. 
It should return nil if the queue is empty.
You may assume that none of the values stored in the queue are 
nil (however, nil may be used to designate empty spots in the buffer).
=end
class CircularQueue
	attr_accessor :buffer, :oldest_ind, :current_ind

	def initialize(size)
		@buffer = [nil] * size
		@oldest_ind = 0
		@current_ind = 0
	end

	def get_next(ind)
		# binding.pry
		(ind + 1) % @buffer.size
		# binding.pry
	end

	def dequeue
		if buffer.all?(nil)
			return nil
		end
		oldest_elem = buffer[oldest_ind]
		self.buffer[oldest_ind] = nil
		self.oldest_ind = get_next(oldest_ind)
		oldest_elem
	end

	def enqueue(val)
		dequeue if current_ind == oldest_ind && !(buffer.all?(nil))
		# binding.pry
		self.buffer[current_ind] = val
		# binding.pry
		self.current_ind = get_next(current_ind)
	end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

=begin
STACK MACHINE INTERPRETATION - Write a class that implements a miniature 
stack-and-register-based programming language that has the following 
commands:

n Place a value n in the "register". Do not modify the stack.
PUSH Push the register value on to the stack. Leave the value in the 
	register.
ADD Pops a value from the stack and adds it to the register value, 
	storing the result in the register.
SUB Pops a value from the stack and subtracts it from the register 
	value, storing the result in the register.
MULT Pops a value from the stack and multiplies it by the register 
	value, storing the result in the register.
DIV Pops a value from the stack and divides it into the register 
	value, storing the integer result in the register.
MOD Pops a value from the stack and divides it into the register 
	value, storing the integer remainder of the division in the register.
POP Remove the topmost item from the stack and place in register
PRINT Print the register value
All operations are integer operations (which is only important with 
	DIV and MOD).

Programs will be supplied to your language method via a string 
passed in as an argument. Your program should produce an error if an 
unexpected item is present in the string, or if a required stack 
value is not on the stack when it should be (the stack is empty). 
In all error cases, no further processing should be performed on the 
program.

You should initialize the register to 0.
=end
require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
	attr_accessor :program, :register, :stack

	COMMANDS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT).to_set

	def initialize(program)
		@program = program
	end

	def eval
    @stack = []
    @register = 0
    @program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

	private

  def eval_token(token)
    if COMMANDS.include?(token)                 # if valid command
      send(token.downcase)                      # call method
    elsif token =~ /\A[-+]?\d+\z/               # if digit, push to register
      @register = token.to_i
    else																				# raise error
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

	def push
		stack.push(register)
	end

	def add
		self.register += pop
	end

	def sub
		self.register -= pop
	end

	def mult
		self.register *= pop
	end

	def div
		self.register /= pop
	end

	def mod
		self.register %= pop
	end

	def pop
		raise EmptyStackError, "Empty stack!" if @stack.empty?
		self.register = stack.pop
	end
	
	def print
		puts register
	end

end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

=begin
NUMBER GUESSER 1 - Create an object-oriented number guessing class 
for numbers in the range 1 to 100, with a limit of 7 guesses per game. 
NUMBER GUESSER 2 - In the previous exercise, you wrote a number guessing 
game that determines a secret number between 1 and 100, and gives the 
user 7 opportunities to guess the number.
Update your solution to accept a low and high value when you create a 
GuessingGame object, and use those values to compute a secret number 
for the game. You should also change the number of guesses allowed so 
the user can always win if she uses a good strategy. You can compute 
the number of guesses with:
=end

class GuessingGame
	attr_accessor :guesses_remaining, :secret_num, :player
	attr_reader :valid_guesses, :max_guesses

	def initialize(from, to)
		@secret_num = nil
		@player = Player.new
		@valid_guesses = (from..to).to_a
		@max_guesses = Math.log2(to - from + 1).to_i + 1
		@guesses_remaining = max_guesses
	end

	def play
		reset
		loop do
			puts ""
			show_guesses_left
			get_guess
			result
			puts ""
			break if guess_correct? || no_guesses_left?
		end
		if guess_correct?
			puts "You won!"
		elsif no_guesses_left?
			puts "You have no more guesses. You lost!"
		end
	end

	private

	def show_guesses_left
		puts "You have #{guesses_remaining} guesses remaining."
	end

	def get_guess
		choice = nil
		loop do 
			print "Enter a number between #{valid_guesses[0]} and #{valid_guesses[-1]}: "
			choice = gets.chomp.to_i
			break if valid_guesses.include?(choice)
			puts "Invalid guess."
		end
		self.player.guess = choice
		self.guesses_remaining -= 1
	end

	def result
		if player.guess > secret_num
			puts "Your guess is too high."
		elsif player.guess < secret_num
			puts "Your guess is too low."
		else
			puts "That's the number!"
		end
	end

	def guess_correct?
		player.guess == secret_num
	end

	def no_guesses_left?
		self.guesses_remaining == 0
	end

	def reset
		self.guesses_remaining = max_guesses
		self.secret_num = valid_guesses.sample
		self.player.guess = nil
	end
end

class Player
	attr_accessor :guess

	def initialize
		@guess = nil
	end
end

game = GuessingGame.new(501, 1500)
# game.play

# game.play

=begin
HIGHEST AND LOWEST RANKING CARDS - Update this class so you can use it 
to determine the lowest ranking and highest ranking cards in an Array 
of Card objects:
For this exercise, numeric cards are low cards, ordered from 2 through 
10. Jacks are higher than 10s, Queens are higher than Jacks, Kings are 
higher than Queens, and Aces are higher than Kings. The suit plays no 
part in the relative ranking of cards.

If you have two or more cards of the same rank in your list, your min 
and max methods should return one of the matching cards; it doesn't 
matter which one.

Besides any methods needed to determine the lowest and highest cards, 
create a #to_s method that returns a String representation of the 
card, e.g., "Jack of Diamonds", "4 of Clubs", etc.
=end
class Card
	include Comparable

  attr_reader :rank, :suit, :value

	CARD_VALUES = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
		@value = CARD_VALUES.fetch(rank, rank)
  end

	def <=>(other)
    value <=> other.value
  end

	def to_s
		"#{rank} of #{suit}"
	end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards 																				# 2 of Hearts
puts cards.min == Card.new(2, 'Hearts') 					# 10 of Diamonds
puts cards.max == Card.new('Ace', 'Clubs') 				# Ace of Clubs

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

=begin
DECK OF CARDS - Using the Card class from the previous exercise, create 
a Deck class that contains all of the standard 52 playing cards. Use 
the following code to start your work:
The Deck class should provide a #draw method to deal one card. The 
Deck should be shuffled when it is initialized and, if it runs out 
of cards, it should reset itself by generating a new set of 52 
shuffled cards.
=end
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

	def initialize
		@deck = []
		populate
	end

	def populate 
		RANKS.each do |rank|
			SUITS.each do |suit|
				@deck << Card.new(rank, suit)
			end
		end
		@deck = @deck.shuffle!
	end

	def draw
		populate if @deck.empty?
		@deck.pop
	end

	def reset
		populate
	end
end


deck = Deck.new
# puts deck
drawn = []
52.times { drawn << deck.draw }
puts drawn
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.

=begin
POKER - In the previous two exercises, you developed a Card class and a 
Deck class. You are now going to use those classes to create and 
evaluate poker hands. Create a class, PokerHand, that takes 5 cards 
from a Deck of Cards and evaluates those cards as a Poker hand.
=end
class PokerHand
	attr_reader :cards, :values

	ROYAL_VALUES = (10..14).to_a
	RANKS = (2..10).to_a + ['Jack', 'Queen', 'King', 'Ace']
	CARD_VALUES = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(deck)
		@cards = []
		5.times do
      card = deck.draw
      @cards << card
    end
		@values = get_values.sort
  end

  def print
		cards.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

	def get_values
		cards.map { |card| card.value }
	end

	def same_suit?
		suit = cards[0].suit
		cards.all? { |card| card.suit == suit }
	end

	def in_order?
		last_val = values.first - 1
		values.all? do |val|
			last_val += 1
			val == last_val
		end
	end

  def royal_flush?
		same_suit? && values == ROYAL_VALUES
	end

  def straight_flush?
		same_suit? && in_order?
  end

  def four_of_a_kind?
		values.count(values.first) == 4 || values.count(values.last) == 4
  end

  def full_house?
		values.count(values.first) == 3 && values.count(values.last) == 2 ||
		values.count(values.first) == 2 && values.count(values.last) == 3
  end

  def flush?
		same_suit?
  end

  def straight?
		in_order?
  end

  def three_of_a_kind?
		values.any? { |val| values.count(val) == 3 }
  end

  def two_pair?
		num_pairs = 0
		values.uniq.each { |val| num_pairs += 1 if values.count(val) == 2}
		num_pairs == 2
  end

  def pair?
		values.any? { |val| values.count(val) == 2 }
  end
end


hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate
# 5 of Clubs
# 7 of Diamonds
# Ace of Hearts
# 7 of Clubs
# 5 of Spades
# Two pair

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'