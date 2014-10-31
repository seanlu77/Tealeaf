class Player
  attr_accessor :name, :choice, :senario

  def initialize(n)
    @name = n
  end

  def check_result(obj)
    self.senario[self.choice][obj.choice]
  end
end

class HumanPlayer < Player

  def get_choice
    while true
      puts "choose from p/r/s:"
      print '=>'
      break if ['p', 'r','s'].include?(self.choice = gets.chomp)
    end
  end

end

class ComputerPlayer < Player

  def get_choice
    self.choice = ['p', 'r', 's'].sample
  end

end

while true

  puts "what's your name?"
  print '=>'
  player_name = gets.chomp
  
  player = HumanPlayer.new(player_name)
  player.get_choice
  player.senario = {'p' => {'p' => "It's a tie!",
                            'r' => "paper smushes rock, you win!",
                            's' => "scissors cut paper, computer win!"},

                    'r' => {'p' => "paper smushes rock, computer win!",
                            'r' => "It's a tie!",
                            's' => "rock smashes scissors, you win!"},

                    's' => {'p' => "scissors cut paper, you win!",
                            'r' => "rock smashes scissors, computer win!",
                            's' => "It's a tie!"}
                    }

  computer = ComputerPlayer.new('computer')
  computer.get_choice

  puts "#{player.name} chose #{player.choice}, #{computer.name} chose #{computer.choice}"
  puts player.check_result(computer)

  print "play again?(y/n)"
  break if gets.chomp.downcase != 'y'
end



