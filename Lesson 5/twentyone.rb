class TwentyOne
	def initialize
	end

	def start
		welcome_message
		deal_cards # 2 cards each
		show_initial_cards
		player_turn # hit or stay
		break if player_bust? # lose if player bust, dealer turn if player stay
		dealer_turn # hit until 17
		break if dealer_bust? # player wins if dealer busts
		show_result # one with highest total wins, nobody wins if tie
		goodbye_message
	end
end

class Deck
	def initialize
		@cards = [] # array of card objects
	end

	# def deal
	# end
end

class Card
	def initialize(num, suite)
		@num = num
		@suite = suite
	end
end

class Participant
	def initialize(participant)
		@participant = participant
		@cards = [] # dealt cards
	end

	def hit
	end

	def stay
	end

	def busted?
	end

	def total
	end
end

class Player
end

class Dealer
	# def deal
	# end
end

TwentyOne.new.start