# A blackjack program based on solution videos

require 'pry'

def calculate_total(cards) # cards = [[Suit, Value], [Suit, Value]]
	arr = cards.map {|a| a[1]}

	total = 0
	arr.each do |value|
		if value == "Ace"
			total += 11
		elsif value.to_i == 0
			total += 10 # a+=10 is equivalent to a = a + 10
		else
			total += value.to_i
		end
	end

	#correct for aces
	arr.select {|e| e == "Ace"}.count.times do
		if total > 21
			total -= 10
		end
	end
	total
end

# Start the game
begin
puts "Welcome to Blackjack!"

# set up deck 

suits = ["Hearts", "Diamonds", "Spades", "Clubs"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack",
"Queen", "King", "Ace"]

deck = suits.product(cards)
deck.shuffle!

# deal cards -- initial gameplay

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop



puts "Your cards are " + mycards.to_s
mytotal = calculate_total(mycards)
puts "Dealer's cards are " + dealercards.to_s
dealertotal = calculate_total(dealercards)

# show cards

puts "Dealer has: #{dealercards[0]} and #{dealercards[1]} for a total of #{dealertotal}."
puts "You have: #{mycards[0]} and #{mycards[1]} for a total of #{mytotal}."
puts ""

# Hit or stay?

if mytotal == 21
	puts "Congratulations. You hit blackjack! You win!"
	exit
end

while mytotal < 21
	puts "What would you like to do (1 for hit, 2 for stay)?"
	hit_or_stay = gets.chomp
	if !["1", "2"].include?(hit_or_stay)
		puts ""
		puts "Error. Please enter a number 1 or 2." 
		next
	end
	if hit_or_stay == "2"
		puts ""
		puts "You chose to stay."
		break
	end
	new_card = deck.pop
	puts "You received the card #{new_card}."
	mycards << new_card
	mytotal = calculate_total(mycards)
	puts ""
	puts "Your total is now #{mytotal}."
	if mytotal == 21
		puts ""
		puts "Congratulations! You hit blackjack! You win!"
		exit
	elsif mytotal > 21
		puts ""
		puts "Sorry. You busted."
		exit
	end
end

# dealer turn

if dealertotal == 21
	puts ""
	puts "Sorry dealer hit blackjack. You lose."
	exit
end

while dealertotal < 17 
	new_card = deck.pop
	puts "" 
	puts "Dealer received the card #{new_card}."
	dealercards << new_card
	dealertotal = calculate_total(dealercards)
	puts "Dealer's total is now #{dealertotal}."
	if dealertotal == 21
		puts "Sorry dealer hit blackjack. You lose."
		exit
	elsif dealertotal > 21
		puts "Congratulations! Dealer busted. You win!"
		exit
	end
end

# compare hands

puts "Dealer's cards:"
dealercards.each do |card|
	puts "=> #{card}"
end
puts ""
puts ""
puts "Your cards:"
mycards.each do |card|
	puts "=> #{card}"
end

puts ""

if dealertotal > mytotal
	puts "Sorry. Dealer won."
elsif mytotal > dealertotal
	puts "Congratulations! You win!"
else
	puts "It's a tie."
end

begin 
	puts "Would you like to play again (Y/N)?"
	play = gets.chomp.upcase!
	ans_yes = ["YES", "Y"].include?(play)
	ans_no = ["NO", "N"].include?(play)
	if ans_yes != true && ans_no != true
		puts "Error retry."
	elsif ans_yes == true
		puts "OK!"
		puts ""
		puts ""
		puts ""
	elsif ans_no == true
		puts "Ok! Come again another time."
	end
end until ans_yes == true || ans_no == true

end until play == "N" || play == "NO"
