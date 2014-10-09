# Here we go with the blackjack game!
# What a wild and ugly code...first try. Will fix soon...
# Psuedo-code

# 1. Welcome to the game. Ask for user's name.
# 2. Explain directions.

# 3. Deal the user and the computer two cards from a 52-card deck.
# 4. Player goes first
# 	if >21, bust and loss
# 	elsif =21, blackjack and win
# 	elsif <21, ask if hit/stay
# 		if hit deal another card
# 			check bust/win/hit
# 		else 
# 			stay
# 5. Computer goes second
# 	if >21, bust and loss
# 	elsif = 21, blackjack and win
# 	elsif <17, hit
# 		deal another card
# 		check if bust/win
# 	else
# 		stay
# 6. if neither person got blackjack 
# 	compare sums of cards for each player
# 	player with larger sum wins

require 'pry'
system('cls')
puts "Welcome to the Tea Leaf casino's blackjack table."
puts "What's your name?"
name = gets.chomp
puts "Hello, #{name}. Do you know how to play (Y/N)?"
answer = gets.chomp.upcase!
if answer == "NO" || answer == "N"
	begin 
	puts "Here are the rules: 
	Blackjack is a card game where you calculate the sum of 
		the values of your cards and try to hit 21, aka blackjack.
	I deal you and myself two cards to start. 
		Face cards = whatever numerical value they show
		Suit cards (J,Q,K)  = 10
		Aces = 11 or 1, your choice
	If you have blackjack from these two cards, you win. 
	If not, you then choose either to hit or stay. 
		Hit = deal another card
			If the new sum > 21, you bust and lose.
			If the new sum = 21, you win.
			If the new sum < 21, you can hit again otherwise:
		You can stay.
	Then I go. 
		I must hit until the sum = 17. 
		After that, it's to my discretion. I can hit again or stay.
		If sum = 21, I win.
		If sum > 21, I bust and lose.
		If sum < 21, we compare sums, and the one with the higher value begins.
	Then I ask if you want to play again.
		If you say yes, then we play again. 
		If you say no, you can try your hands at poker."
	puts "Do you understand now (Y/N)?"
	answer2 = gets.chomp.upcase!
	end until answer2 == "YES" || answer2 == "Y"
end
begin
puts ""
puts "Okay, #{name}, let's play!"
puts ""

all_cards_available = {"2 of hearts" => 2, "3 of hearts" => 3, "4 of hearts" => 4, 
			"5 of hearts" => 5, "6 of hearts" => 6, "7 of hearts" => 7, "8 of hearts" => 8,
			"9 of hearts" => 9, "10 of hearts" => 10, "Jack of hearts" => 10, "Queen of hearts" => 10,
			"King of hearts" => 10, "Ace of hearts" => 11,


			"2 of spades" => 2, "3 of spades" => 3, "4 of spades" => 4, 
			"5 of spades" => 5, "6 of spades" => 6, "7 of spades" => 7, "8 of spades" => 8,
			"9 of spades" => 9, "10 of spades" => 10, "Jack of spades" => 10, "Queen of spades" => 10,
			"King of spades" => 10, "Ace of spades" => 11,

			"2 of diamonds" => 2, "3 of diamonds" => 3, "4 of diamonds" => 4, 
			"5 of diamonds" => 5, "6 of diamonds" => 6, "7 of diamonds" => 7, "8 of diamonds" => 8,
			"9 of diamonds" => 9, "10 of diamonds" => 10, "Jack of diamonds" => 10, "Queen of diamonds" => 10,
			"King of diamonds" => 10, "Ace of diamonds" => 11,

			"2 of clubs" => 2, "3 of clubs" => 3, "4 of clubs" => 4, 
			"5 of clubs" => 5, "6 of clubs" => 6, "7 of clubs" => 7, "8 of clubs" => 8,
			"9 of clubs" => 9, "10 of clubs" => 10, "Jack of clubs" => 10, "Queen of clubs" => 10,
			"King of clubs" => 10, "Ace of clubs" => 11,
		}
$sum = 0
$sum_comp = 0
def deal_cards(mycards, turn)
	if turn == 0
		puts "Your turn!" 
		puts ""
		two_cards = mycards.keys.sample(2)
		puts "You received the #{two_cards[0]} and the #{two_cards[1]}."
		if two_cards[0] == "Ace of hearts" || two_cards[0] == "Ace of spades" || two_cards[0] == "Ace of diamonds" || two_cards[0] == "Ace of clubs"
			begin 
			puts "What value would you like to give the ace (1 or 11)?"
			ace_val = gets.chomp.to_i
			mycards[two_cards[0]] = ace_val
			end until ace_val == 1 || ace_val == 11
		elsif two_cards[1] == "Ace of hearts" || two_cards[1] == "Ace of spades" || two_cards[1] == "Ace of diamonds" || two_cards[1] == "Ace of clubs"
			begin 
			puts "What value would you like to give the ace (1 or 11)?"
			ace_val = gets.chomp.to_i
			mycards[two_cards[1]] = ace_val
			end until ace_val == 1 || ace_val == 11
		elsif two_cards[0] == "Ace of hearts" || two_cards[0] == "Ace of spades" || two_cards[0] == "Ace of diamonds" || two_cards[0] == "Ace of clubs" && two_cards[1] == "Ace of hearts" || two_cards[1] == "Ace of spades" || two_cards[1] == "Ace of diamonds" || two_cards[1] == "Ace of clubs"
			mycards[two_cards[0]] = 1
			mycards[two_cards[1]] = 11
		end
		value1 = mycards.fetch(two_cards[0]).to_i
		value2 = mycards.fetch(two_cards[1]).to_i
		$sum = value1 + value2
		puts "This puts your sum at #{$sum}."
		mycards.delete(two_cards[0])
		mycards.delete(two_cards[1])
	else
		comp_two_cards = mycards.keys.sample(2)
		puts "Dealer received the #{comp_two_cards[0]} and the #{comp_two_cards[1]}."
		value3 = mycards.fetch(comp_two_cards[0]).to_i
		value4 = mycards.fetch(comp_two_cards[1]).to_i
		if value4 <= 10 && comp_two_cards[0] == "Ace of hearts" || comp_two_cards[0] == "Ace of spades" || comp_two_cards[0] == "Ace of diamonds" || comp_two_cards[0] == "Ace of clubs"
			value3 = 11
		elsif value3<=10 && comp_two_cards[1] == "Ace of hearts" || comp_two_cards[1] == "Ace of spades" || comp_two_cards[1] == "Ace of diamonds" || comp_two_cards[1] == "Ace of clubs"
			value4 = 11
		elsif value4 >= 10 && comp_two_cards[0] == "Ace of hearts" || comp_two_cards[0] == "Ace of spades" || comp_two_cards[0] == "Ace of diamonds" || comp_two_cards[0] == "Ace of clubs"
			value3 = 1
		elsif value3>=10 && comp_two_cards[1] == "Ace of hearts" || comp_two_cards[1] == "Ace of spades" || comp_two_cards[1] == "Ace of diamonds" || comp_two_cards[1] == "Ace of clubs"
			value4 = 11
		end
		$sum_comp = value3 + value4
		puts "This puts the computer's sum at #{$sum_comp}."
		mycards.delete(comp_two_cards[0])
		mycards.delete(comp_two_cards[1])
	end
end

def user_hit_stay(mycards, sum)
	begin 
		while sum < 21
			puts ""
			puts "What would you like to do: hit or stay (H/S)?"
			hit_ans = gets.chomp.upcase!
			if hit_ans == "H"
				hit_card = mycards.keys.sample(1)
				binding.pry
				puts ""
				puts "You received the #{hit_card[0]}."
				value_hit_card = mycards.fetch(hit_card[0]).to_i
				if value_hit_card == 11
					begin 
					puts "What would you like the Ace to equal (1 or 11)?"
					value_hit_card = gets.chomp.to_i
					end until value_hit_card == 1 || value_hit_card == 11
				end
				sum = sum + value_hit_card
				$sum = sum
				puts ""
				puts "Your new sum is #{sum}."
				mycards.delete(hit_card[0])
			else
				break
			end
		end
	end
end

def comp_hit_stay(mycards, sum_comp)
	begin 
		while sum_comp < 17
			hit_card = mycards.keys.sample(1)
			puts "Computer hit! He received #{hit_card[0]}." 
			value_hit_card = mycards.fetch(hit_card[0]).to_i
			if value_hit_card == 11
				begin
					puts "What would you like the Ace to equal (1 or 11)?"
					value_hit_card == gets.chomp.to_i
				end until value_hit_card == 1 || value_hit_card == 11
			end
			sum_comp = sum_comp + value_hit_card
			$sum_comp = sum_comp
			puts "His new sum is #{sum_comp}."
			mycards.delete(hit_card[0])
		end
	end
end

def check_if_bust(sum, turn)
	if turn == 0 
		if sum > 21
			return "Bust! You lose!"
		elsif sum == 21
			return "Blackjack! You win!"
		else
			return "a"
		end
	else
		if sum > 21
			return "Bust! Computer loses. You win!"
		elsif sum == 21
			return "Blackjack! Computer wins! You lose."
		else
			return "b"
		end
	end
end

def compare_values(sum, sum_comp)
	if sum<sum_comp
		puts "Computer wins. #{sum_comp} is greater than #{sum}."
	elsif sum == sum_comp
		puts "It's a tie! #{sum_comp} is equal to #{sum}."
	else
		puts "#{name} won! #{sum} is greater than #{sum_comp}."
	end
end





deal_cards(all_cards_available, 0)
check_if_bust($sum, 0)
if check_if_bust($sum, 0) == "a"
	deal_cards(all_cards_available, 1)
	check_if_bust($sum_comp, 1)
	if check_if_bust($sum_comp, 1) == "b"
		user_hit_stay(all_cards_available, $sum)
		check_if_bust($sum, 0)
		if check_if_bust($sum, 0) == "a"
			comp_hit_stay(all_cards_available, $sum_comp)
			check_if_bust($sum_comp, 1)
			if check_if_bust($sum_comp, 1) == "b"
				compare_values($sum, $sum_comp)
			else
				puts check_if_bust($sum_comp, 1)
			end
		else
			puts check_if_bust($sum, 0)
		end
	else
		puts check_if_bust($sum_comp, 1)
	end
else
	puts check_if_bust($sum, 0)
end

	
puts "Would you like to play again (Y/N)?"
input = gets.chomp.upcase!

end until input == "N"