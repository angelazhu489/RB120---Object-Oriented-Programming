require 'pry'

class RPSGame
  attr_accessor :human, :computer, :name

  def initialize
    @human = Human.new
    @computer = Computer.new
  end
	
	def display_welcome_message
		puts "-----------------------------------------------"
		puts "Welcome to Angela's Rock, Paper, Scissors Game!"
	end

	def display_goodbye_message
		puts "Thanks for playing, #{human.name}!"
	end

	def display_winner
		puts "#{human.name} chose #{human.move}." 
		puts "Computer chose #{computer.move}." 
		if human.move > computer.move
			puts "#{human.name} won!" 
			human.score += 1
		elsif computer.move > human.move
			puts "#{human.name} lost." 
			computer.score += 1
		else 
			puts "It's a tie!"
		end
		human.display_score
		computer.display_score
	end

	def play_again?
		choice = nil
		loop do
			puts "Do you want to play again? (y/n):"
			print "=> "
			choice = gets.chomp.chr.downcase
			break if ('yn').include?(choice)
			puts "Not a valid choice."
		end
		return true if choice == 'y'
		false
	end

  def play
		display_welcome_message
		human.set_name
		loop do
			human.score = 0
			computer.score = 0
			loop do
				human.choose
				computer.choose
				display_winner
				break if human.score == 10 || computer.score == 10
			end
			break unless play_again?
		end
		display_goodbye_message
	end
end

class Player
	attr_accessor :name, :move, :score

	def initialize
		@name = 'Computer'
		@score = 0
	end

	def display_score
		puts "#{name}'s Score: #{score}"
	end
end

class Human < Player
	def set_name
		temp_name = nil
		loop do
			puts "Whats your name?: "
			print "=> "
			temp_name = gets.chomp.capitalize
			break unless temp_name.empty?
			"Sorry, must give a name."
		end
		self.name = temp_name
	end

	def choose
		choice = nil
		loop do
			puts "Rock (r), paper (p), scissors (s), lizard (l), or spock (sp)?: "
			print "=> "
			choice = gets.chomp.downcase
			break if 'sp' == choice[0, 2] || ('rpsl').include?(choice.chr)
			puts "Not a valid choice."
		end
		case choice.chr
		when 'r'
			self.move = Move.new('rock')
		when 'p'
			self.move = Move.new('paper')
		when 'l'
			self.move = Move.new('lizard')
		else
			choice[0, 2] == 'sp' ? self.move = Move.new('spock') : self.move = Move.new('scissors')
		end
	end
end

class Computer < Player
	def choose
		self.move = Move.new(Move::VALUES.sample)
	end

end

class Move
	attr_accessor :choice
	VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  def initialize(choice)
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
		@choice = choice
  end

	def >(other)
		case choice
		when 'rock'
			return true if other.choice == 'scissors' || other.choice == 'lizard'
		when 'paper'
			return true if other.choice == 'rock' || other.choice == 'spock'
		when 'scissors'
			return true if other.choice == 'paper' || other.choice == 'lizard'
		when 'lizard'
			return true if other.choice == 'paper' || other.choice == 'spock'
		else
			return true if other.choice == 'rock' || other.choice == 'scissors'
		end
		return false
	end

	def to_s
		choice
	end
end

class Rule
	def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2); end

# Need an "engine" of some sort to orchestrate the objects.
# This is where the procedural program flow should be.
RPSGame.new.play