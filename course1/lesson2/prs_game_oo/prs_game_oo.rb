class Hand
  attr_accessor :sign

  def initialize
    @sign = ''
  end

end

class Player

  HANDSIGNS = ['p', 'r', 's']
  attr_accessor :name, :hand

  def initialize(n)
    @name = n
    @hand = Hand.new
  end

end

class HumanPlayer < Player

  def choose_hand_sign
    while true
      puts "choose from p/r/s:"
      print '=>'
      break if HANDSIGNS.include?(self.hand.sign = gets.chomp)
    end
  end

end

class ComputerPlayer < Player

  def choose_hand_sign
    self.hand.sign = HANDSIGNS.sample
  end

end

class Game
  SENARIO= {'p' => {'p' => "It's a tie!",
                    'r' => "paper smushes rock, you win!",
                    's' => "scissors cut paper, computer win!"},

            'r' => {'p' => "paper smushes rock, computer win!",
                    'r' => "It's a tie!",
                    's' => "rock smashes scissors, you win!"},

            's' => {'p' => "scissors cut paper, you win!",
                    'r' => "rock smashes scissors, computer win!",
                    's' => "It's a tie!"}
            }

  attr_accessor :player, :computer

  def initialize
    @player = HumanPlayer.new('sean')
    @computer = ComputerPlayer.new('computer')
  end

  def check_result(player1, player2)
    SENARIO[player1.hand.sign][player2.hand.sign]
  end

  def play
    player.choose_hand_sign
    computer.choose_hand_sign
    puts check_result(player, computer)
  end

end



while true

  Game.new.play

  print "play again?(y/n)"
  break if gets.chomp.downcase != 'y'
  
end



