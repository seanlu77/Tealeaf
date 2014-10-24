# paper rock scissors game
# player vs computer
# 1. get player's choice
# 1.1 validate player's choice (p/r/s)
# 2. get computer's choice
# 2.1 randomly choose from (p/r/s)
# 3 do the compare, return the result
# 4 display the result
# 5 play again?


# get player's choice 
def get_player_choice
  print "player's choice (p-paper, r-rock, s-scissors): "
  begin
    player = gets.chomp.downcase 
    print "It's not a valid choice, please choose from p/r/s: " unless ['p', 'r', 's'].include?(player)
  end until ['p', 'r', 's'].include?(player)
  puts "player's choice: #{player}"
  return player
end

# get computer's choice
def get_computer_choice
  computer = ['p', 'r', 's'].sample
  puts "computer's choice: #{computer}"
  return computer
end

# follow the rule and do the compare
def do_compare(player, computer)
  # all p/r/s combination scenario
  scenario = {'p' => {'p' => "It's a tie!",
                      'r' => "paper smushes rock, you win!",
                      's' => "scissors cut paper, computer win!"},

              'r' => {'p' => "paper smushes rock, computer win!",
                      'r' => "It's a tie!",
                      's' => "rock smashes scissors, you win!"},

              's' => {'p' => "scissors cut paper, you win!",
                      'r' => "rock smashes scissors, computer win!",
                      's' => "It's a tie!"}
              }

  scenario[player][computer]
end

puts "Game Paper Rock Scissors......"
puts

# main loop
begin

  player_choice = get_player_choice
  
  computer_choice = get_computer_choice
  
  result = do_compare(player_choice, computer_choice)
  
  puts result

  print "Play again?(y/n)"
  game_over = true if gets.chomp.downcase != 'y'

end until game_over

puts "Game over!"
