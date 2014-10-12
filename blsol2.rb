# After watching the blackjack solution video,
# I'm going to try to redo my blackjack game
# to be more concise and effective...



# Welcome players to the game.

system('cls')
puts "Welcome to Tea Leaf's blackjack table."
puts "What is your name?"
name = gets.chomp
puts ""
puts "Nice to meet you, #{name}."
puts ""
puts "Do you know how to play blackjack (Y/N)?"
ans = gets.chomp.upcase!
ans2 = ''
if ans == "NO" || ans == "N"
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
		puts "Do you understand know?"
		ans2 = gets.chomp.upcase!
	end until ans2 == "YES" || ans2 == "Y"
end 

puts "You made it through!"