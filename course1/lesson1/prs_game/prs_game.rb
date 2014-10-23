puts "Play Paper Rock Scissors game!"

#define three types used in the game
CHOICES = {'P' => 'paper', 'R' => 'rock', 'S' => 'scissors'}

#define all scenarios when player vs. computer
SCENARIO = {paper:    {paper: "It's a tie!",
                       rock: "Paper smushes rock! You win!",
                       scissors: "Scissors cut paper! You lose"
                     },

            rock:     {paper: "Paper smushes rock! You win!",
                       rock: "It's a tie!",
                       scissors: "Rock crushes scissors! You lose!"
                     },

            scissors: {paper: "Scissors cut paper! You win!",
                       rock: "Rock crushes scissors! You lose!",
                       scissors: "It's a tie!"
                     }

            }

game_on = TRUE

while game_on

  #make sure player's input is valid
  begin 
    puts "Please choose one: (P/R/S), P-Paper, R-Rock, S-Scissors "
    input = gets.chomp.upcase
  end until CHOICES.keys.include?(input)

  player = CHOICES[input].to_sym
  
  #choose from CHOICES randomly
  computer = CHOICES[CHOICES.keys.sample].to_sym
  
  #choose the right scenario from the SCENARIO hash BY player and computer
  puts SCENARIO[player][computer]

  
  begin
    puts "Play again? (Y/N)"
    input = gets.chomp.upcase
    if input == "N"
      game_on = FALSE
      puts "Game over, good bye!"
    elsif input != "Y"
      puts "You need to choose Y or N."
    end
  end until input == "N" || input == "Y"

end
