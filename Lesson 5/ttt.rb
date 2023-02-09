require 'pry'

class TTTGame
	attr_accessor :board, :current_marker
	attr_reader :human, :computer
	HUMAN_MARKER = 'X'
	COMP_MARKER = 'O'
	EMPTY_MARKER = ' '
	FIRST_TO_MOVE = HUMAN_MARKER

	def play
		clear
		display_welcome_message
		loop do
			display_board
			loop do
				current_player_moves
				break if board.someone_won? || board.full?
				clear_screen_and_display_board if human_turn?
				# human_moves
				# break if board.someone_won? || board.full?

				# computer_moves
				# break if board.someone_won? || board.full?
				# clear_screen_and_display_board
			end
			display_result
			break unless play_again?
			reset
		end
    display_goodbye_message
	end

	private

	def initialize
		@board = Board.new
		@human = Player.new(HUMAN_MARKER)
		@computer = Player.new(COMP_MARKER)
		@current_marker = FIRST_TO_MOVE
	end

	def display_welcome_message
		puts "------------ WELCOME TO ANGELA'S TIC TAC TOE GAME! ------------"
	end

	def display_goodbye_message
		puts "----------------- THANKS FOR PLAYING MY GAME! -----------------"
	end

	def clear
		system 'clear'
	end

	def clear_screen_and_display_board
		clear
		display_board
	end

	def display_board
		puts "You are #{HUMAN_MARKER}"
		puts "Computer is #{COMP_MARKER}"
		puts ""
		board.draw
		puts ""
	end

	def human_moves
		choice = nil
		empty_squares = board.get_squares(EMPTY_MARKER)
		loop do 
			print "Choose a square (#{empty_squares}): "
			choice = gets.chomp.to_i
			break if empty_squares.include?(choice)
			puts "Not a valid choice :-("
		end
		board[choice - 1] = human.marker
	end

	def computer_moves
		choice = board.get_squares(EMPTY_MARKER).sample
		board[choice - 1] = computer.marker
	end

	def display_result
		clear_screen_and_display_board
		winner = board.winning_marker
		case winner
		when HUMAN_MARKER
			puts "YOU WON :-)"
		when COMP_MARKER
			puts "You lost :-("
		else
			puts "It's a tie!"
		end
	end

	def play_again?
		choice = nil
		loop do
			print "Do you want to play again? (y/n): "
			choice = gets.chomp[0].downcase
			break if 'yn'.include?(choice)
			puts "Not a valid choice :-("
		end
		choice == 'y'
	end

	def reset
		board.reset
		clear
		self.current_marker = FIRST_TO_MOVE
	end

	def current_player_moves
		if human_turn?
			human_moves
			self.current_marker = COMP_MARKER
		else
			computer_moves
			self.current_marker = HUMAN_MARKER
		end
	end

	def human_turn?
		current_marker == HUMAN_MARKER
	end
end

class Board
	attr_accessor :squares
	WINNING_ROWS = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
									[0, 3, 6], [1, 4, 7], [2, 5, 8],
									[0, 4, 8], [2, 4, 6]]

	def initialize
		reset
	end

	def draw
		puts "     |     |"
		puts "  #{squares[0]}  |  #{squares[1]}  |  #{squares[2]}"
		puts "     |     |"
		puts "-----------------"
		puts "     |     |"
		puts "  #{squares[3]}  |  #{squares[4]}  |  #{squares[5]}"
		puts "     |     |"
		puts "-----------------"
		puts "     |     |"
		puts "  #{squares[6]}  |  #{squares[7]}  |  #{squares[8]}"
		puts "     |     |"
	end

	def []=(ind, marker)
		squares[ind].marker = marker
	end

	def get_squares(marker)
		arr_sqr = []
		squares.each_with_index do |sqr, ind|
			arr_sqr << ind + 1 if sqr.marker == marker
		end
		arr_sqr
	end

	def full?
		get_squares(TTTGame::EMPTY_MARKER).empty?
	end

	def winning_marker
		WINNING_ROWS.each do |row|
			return TTTGame::HUMAN_MARKER if row.all? { |ind| squares[ind].marker == TTTGame::HUMAN_MARKER }
			return TTTGame::COMP_MARKER if row.all? { |ind| squares[ind].marker == TTTGame::COMP_MARKER }
		end
		return nil
	end

	def someone_won?
		!!winning_marker
	end

	def reset
		@squares = []
		9.times{ |_| squares << Square.new }
	end
end

class Square
	attr_accessor :marker
	def initialize(marker=TTTGame::EMPTY_MARKER)
		@marker = marker
	end
	
	def to_s
		marker
	end
end

class Player
	attr_reader :marker
	def initialize(marker)
		@marker = marker
	end
end

game = TTTGame.new
game.play