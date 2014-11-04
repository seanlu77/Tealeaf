require 'pry'


class Board
  WINNING_LINES = [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9'], ['1', '4', '7'], 
                 ['2', '5', '8'], ['3', '6', '9'], ['1', '5', '9'], ['3', '5', '7']]
  attr_accessor :board_content

  def initialize
    @board_content = {}
    ('1'..'9').each {|p| @board_content[p] = ''}
  end

  def draw_board
    system 'clear'
    puts
    puts "     |     |"
    puts "  #{board_content['1']}  |  #{board_content['2']}  |  #{board_content['3']}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board_content['4']}  |  #{board_content['5']}  |  #{board_content['6']}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board_content['7']}  |  #{board_content['8']}  |  #{board_content['9']}"
    puts "     |     |"
    puts
   # puts "Player picks: #{player_arr}, Computer picks: #{computer_arr}"
  end

  # return empty positions 
  def empty_positions
    board_content.select {|p, mark| mark.empty?}
  end

  def is_board_full?
    if empty_positions.empty?
      return true
    else
      return nil
    end
  end

  def is_position_empty?(position)
    if board_content[position] == ''
      return true
    else
      return nil
    end
  end

  def check_winner
    WINNING_LINES.each do |line|
      return "Player wins!" if self.board_content.values_at(*line).count('X') == 3
      return "Computer wins!" if self.board_content.values_at(*line).count('O') == 3
    end
    nil
  end

end

class Player
  attr_accessor :choice

  def make_choice(b_obj)
    begin
      puts "Choose one (1-9): "
      print '=>'
      self.choice = gets.chomp
    end until b_obj.is_position_empty?(choice) && ('1'..'9').include?(choice)
    b_obj.board_content[choice] = 'X'
  end

end


class ComputerPlayer < Player

  def make_choice(b_obj)
    choice = b_obj.empty_positions.keys.sample
    b_obj.board_content[choice] = 'O'
  end

end

class Game

  attr_accessor :human_player, :computer_player, :board

  def initialize
    @board = Board.new
    @human_player = Player.new
    @computer_player = ComputerPlayer.new
  end

  def run
    while true
      board.draw_board
      human_player.make_choice(board)
      board.draw_board
      result = board.check_winner


      break if result || board.is_board_full?

      computer_player.make_choice(board)
      board.draw_board
      result = board.check_winner
      break if result || board.is_board_full?
    end

    if result
      puts result
    else
      puts "It's a tie!"
    end
  end

end

while true

  Game.new.run
  puts "Play again?(y/n)"
  print '=>'
  break if gets.chomp != 'y'
end