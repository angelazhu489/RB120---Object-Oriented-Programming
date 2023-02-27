class Customer; end

class Order
	def initialize
		@burger = Burger.new
		@side = Side.new
		@drink = Drink.new
	end
	
	def meal
		[@burger, @side, @drink]
	end
end

class MealItem
	def initialize
		@option = choose_option
	end
	def to_s
		meal.map(&:to_s).join(', ')
	end
	
	def self.to_s
		self::OPTIONS[@option][:name]
	end
end

class Burger < MealItem
  OPTIONS = {
    '1' => { name: 'LS Burger', cost: 3.00 },
    '2' => { name: 'LS Cheeseburger', cost: 3.50 },
    '3' => { name: 'LS Chicken Burger', cost: 4.50 },
    '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
  }
end

class Side < MealItem
  OPTIONS = {
    '1' => { name: 'Fries', cost: 0.99 },
    '2' => { name: 'Onion Rings', cost: 1.50 }
  }
end

class Drink < MealItem
  OPTIONS = {
    '1' => { name: 'Cola', cost: 1.50 },
    '2' => { name: 'Lemonade', cost: 1.50 },
    '3' => { name: 'Vanilla Shake', cost: 2.00 },
    '4' => { name: 'Chocolate Shake', cost: 2.00 },
    '5' => { name: 'Strawberry Shake', cost: 2.00 }
  }
end

# Nouns: customer, order, meal item, burger, side, drink
# Verbs: place, total, choose option

order = Order.new()