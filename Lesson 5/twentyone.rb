require 'pry'

class TwentyOne
	attr_accessor :deck
	attr_reader :player, :dealer

	def initialize
		@deck = Deck.new
		@player = Participant.new('player')
		@dealer = Participant.new('dealer')
	end

	def start
		system 'clear'
		welcome_message
		loop do 
			deal_initial_cards # 2 cards each
			show_cards

			player_turn
			if player.busted?
				busted
				if play_again?
					reset
					next
				else
				  break
				end
			end

			dealer_turn
			if dealer.busted?
				busted
				if play_again?
					reset
					next
				else
				  break
				end
			end

			# both stayed
			show_cards
			show_result
			play_again? ? reset : break
			# reset if play_again?
		end
		goodbye_message
	end

	def welcome_message
		puts "------------ WELCOME TO ANGELA'S TWENTY ONE TABLE ------------"
	end
	
	def deal_initial_cards
		player.add_card(deck.deal_card)
		player.add_card(deck.deal_card)
		dealer.add_card(deck.deal_card)
		dealer.add_card(deck.deal_card)
	end

	def show_cards
		puts "==============================="
		puts "Player has:"
		player.show_cards
		puts "Total: #{player.total}"
		puts ""
		puts "Dealer has:"
		dealer.show_cards
		puts "Total: #{dealer.total}"
		puts "==============================="
	end

	def player_turn
		puts "==> Your turn..."
		choice = nil
		loop do
			loop do
				print "==> Hit or Stay? (h/s): "
				choice = gets.chomp.downcase[0]
				break if 'hs'.include?(choice)
				puts "==> Not a valid move."
			end
			if choice == 'h'
				player.hit(deck.deal_card)
				show_cards
			else
				player.stay
				break
			end
		end
		choice
	end

	def dealer_turn
		puts "==> Dealer's turn..."
		while dealer.total < 17
			dealer.hit(deck.deal_card)
		end
		dealer.stay unless dealer.busted?
	end

	def busted
		if player.busted?
			puts "==> Player busted :-("
		else
			puts "==> Dealer busted :-)"
		end
	end

	def show_result
		# show_cards
		if player.busted? || dealer.total > player.total && !dealer.busted?
			puts "==> Dealer wins :-("
		elsif dealer.busted? || player.total > dealer.total && !player.busted?
			puts "==> PLAYER WINS :-)"
		else
			puts "==> It's a tie :|"
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
		self.deck = Deck.new
    player.type.hand = []
    dealer.type.hand = []
	end

	def goodbye_message
		puts "--------------- THANKS FOR PLAYING TWENTY ONE ---------------"
	end
end

class Deck
	attr_reader :cards

	SUITES = ['Clovers', 'Spades', 'Hearts', 'Diamonds']
	CARD_VALUES = (2..10).to_a + ['Jack', 'Queen', 'King', 'Ace']

	def initialize
		@cards = [] # array of card objects
		CARD_VALUES.each do |val|
			SUITES.each do |suite|
				@cards << Card.new(val, suite)
			end
		end
	end

	def deal_card
		card = cards.sample
		cards.delete(card)
	end
end

class Card
	NUMBER_CARDS = (2..10).to_a
	ROYAL_CARDS = ['Jack', 'Queen', 'King']
	ROYAL_CARD_VALUE = 10
	ACE = 'Ace'
	ACE_VALUE = [1, 11]
	attr_reader :num, :suite
	def initialize(num, suite)
		@num = num
		@suite = suite
	end

	def get_value(card)
		return num if NUMBER_CARDS.include?(num)
		return ROYAL_CARD_VALUE if ROYAL_CARDS.include?(num)
		return ACE_VALUE if num == ACE
	end

	def to_s
		"#{num} of #{suite}"
	end
end

class Participant
	attr_reader :type

	def initialize(type)
		type == 'player' ? @type = Player.new : @type = Dealer.new
	end

	def add_card(card)
		type.hand << card
	end

	def show_cards
		type.hand.each { |card| puts card }
	end

	def hit(card)
		puts "==> #{type.class} hit."
		add_card(card)
	end

	def stay
		puts "==> #{type.class} stays."
	end

	def busted?
		total > 21
	end

	def total
		sum = 0
		num_aces = 0
		type.hand.each do |card|
			value = card.get_value(card)
			if value.is_a?(Array)
				num_aces += 1
				next
			else
				sum += value
			end
		end
		num_aces.times do
			sum + Card::ACE_VALUE[1] <= 21 ? sum += Card::ACE_VALUE[1] : sum += Card::ACE_VALUE[0]
		end
		sum
	end
end

class Player
	attr_accessor :hand

	def initialize
		@hand = []
	end
end

class Dealer
	attr_accessor :hand

	def initialize
		@hand = []
	end
end

TwentyOne.new.start