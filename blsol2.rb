# After watching the blackjack solution video,
# I'm going to try to redo my blackjack game
# to be more concise and effective...

require 'pry'

# Welcome players to the game.

system('cls')
puts "Welcome to Tea Leaf's blackjack table."
puts "What is your name?"
name = gets.chomp
puts ""
puts "Nice to meet you, #{name}."
puts ""
begin
	puts "Do you know how to play blackjack (Y/N)?"
	ans = gets.chomp.upcase
	if ["Y", "N", "y", "n", "YES", "NO"].include?(ans) == false
		puts "Try again."
	elsif ans == "NO" || ans == "N"
		begin 
			puts ""
			puts "Okay. Here are the instructions:"
			puts ""
			puts "Blackjack is a card game where you calculate the sum of 
					the values of your cards and try to hit 21, aka blackjack.
				I deal you and myself two cards to start. 
					Face cards = whatever numerical value they show
					Suit cards (J,Q,K)  = 10
					Aces = 11 or 1, depending on the player's sum
				If you have blackjack from these two cards, you win. 
				If not, you then choose either to hit or stay. 
					Hit = deal another card
						If the new sum > 21, you bust and lose.
						If the new sum = 21, you win.
						If the new sum < 21, you can hit again otherwise:
					You can also stay whenever you wish.
				Then I go. 
					I must hit until the sum = 17. 
					After that, it's to my discretion. I can hit again or stay.
					If sum = 21, I win.
					If sum > 21, I bust and lose.
					If sum < 21, we compare sums, and the one with the higher value begins.
				Then I ask if you want to play again.
					If you say yes, then we play again. 
					If you say no, you can try your hands at poker."
			puts "Do you understand now?"
			ans = gets.chomp.upcase
		end until ans == "YES" || ans == "Y"
	end
	if ans == "YES" || ans == "Y"
		puts ""
		puts "Okay! Let's go!"
		puts ""
	end 
end until ["Y", "y", "YES"].include?(ans) == true

# Initialize deck.

suits = ["of Hearts", "of Diamonds", "of Spades", "of Clubs"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

deck = cards.product(suits)

				# deck = cards.product(suits).join(" ")
				# puts deck
				# deck = deck.shuffle
				# puts deck


def spacing(cards, newcards)
	cards.each do |a|
		newcards << a.join(" ")
	end
end


def calculate_sum(cards)
	total = 0
	arr = cards.map {|b| b[0]}
	arr.each do |value|
		if value == "Ace"
			total += 11
		elsif value.to_i == 0
			total += 10
		else
			total += value.to_i
		end
	end

	#correct for the aces
	arr.select {|e| e == "Ace"}.count.times do 
		if total > 21
			total -= 10
		end
	end
	total
end


# Dealer shuffles and deals.

puts ""
puts "Dealer's shuffling..."
deck.shuffle!

my_cards = []
dealer_cards = []
my_sp_cards = []
dealer_sp_cards = []

my_cards << deck.pop
dealer_cards << deck.pop
my_cards << deck.pop
dealer_cards << deck.pop
sleep(1)

# First round of turns

spacing(my_cards, my_sp_cards)
spacing(dealer_cards, dealer_sp_cards)

puts ""
puts "#{name}, you received the #{my_sp_cards.join(" and the ")}."
my_total = calculate_sum(my_cards)
puts "This puts your sum at #{my_total}."
puts ""
puts "The dealer received the #{dealer_sp_cards.join(" and the ")}."
dealer_total = calculate_sum(dealer_cards)
puts "This puts the dealer's sum at #{dealer_total}."
puts ""

while my_total < 21
	begin 
	puts "What would you like to do? Hit (H) or Stay (S)?"
	hs_ans = gets.chomp.upcase!
		if ["H", "S"].include?(hs_ans) == false
			puts "Try again."
			puts ""
		end
	end until ["H", "S"].include?(hs_ans) == true
	
	if hs_ans == "H"
		new_card = deck.pop
		my_cards << new_card
		puts "#{name}, you received the #{new_card.join(" ")}."
		my_total = calculate_sum(my_cards)
		puts "You now have a total of #{my_total}."
	else
		break
	end
end


if my_total < 21
	puts ""
	while dealer_total < 17
		new_card = deck.pop
		dealer_cards << new_card
		puts "The dealer hit! He received the #{new_card.join(" ")}"
		dealer_total = calculate_sum(dealer_cards)
		puts "The dealer now has a total of #{dealer_total}."
		puts ""
	end
end

if my_total == 21
	puts ""
	puts "Congratulations! You got blackjack! You win!" 
elsif my_total > 21
	puts ""
	puts "Sorry. You busted. You lose."
elsif dealer_total == 21
	puts ""
	puts "Sorry. Computer hit blackjack! You lose."
elsif dealer_total > 21
	puts ""
	puts "Congratulations! Computer busted! You win!"
else
	if my_total > dealer_total
		puts ""
		puts "Congratulations! You win! Your total is greater than the dealer's total!"
	elsif my_total == dealer_total
		puts ""
		puts "Tie game. At least you didn't lose..."
	else
		puts ""
		puts "Sorry. You lose. Your total is less than the dealer's total."
	end
end
