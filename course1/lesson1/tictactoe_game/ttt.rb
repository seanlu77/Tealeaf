
# draw the game board
def draw_board(board, player_arr, computer_arr)
  system 'clear'
  puts
  puts "     |     |"
  puts "  #{board['1']}  |  #{board['2']}  |  #{board['3']}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board['4']}  |  #{board['5']}  |  #{board['6']}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board['7']}  |  #{board['8']}  |  #{board['9']}"
  puts "     |     |"
  puts
  puts "Player picks: #{player_arr}, Computer picks: #{computer_arr}"
end

def initialize_game(b, player, computer)
  board = {}
  player = []
  computer = []
  ('1'..'9').each {|number| board[number]=''}
  player.clear
  computer.clear
  return board, player, computer
end

# player pick a square number
def player_picks(board, player_arr)
  print "player picks: "
  begin
    player_pick_number = gets.chomp
    print "square #{player_pick_number} was taken! pick again: " if board[player_pick_number]
  end until board[player_pick_number].empty?
  player_arr.push(player_pick_number.to_i)
  board[player_pick_number] = "X"
end

# computer pick a square number
def computer_picks(board, computer_arr)
  empty_board = board.select {|number, mark| mark.empty?}
  computer_pick_number = empty_board.keys.sample
  computer_arr.push(computer_pick_number.to_i)
  board[computer_pick_number] = "O"
end

# check whether anyone wins by counting if "XXX" or "OOO" exists based upon the winning_lines
def win?(board)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9], 
                   [1, 5, 9], [3, 5, 7]]

  winning_lines.each do |line|
    marks = String.new
    line.each do |number|
      marks << board[number.to_s]
    end
    if marks == "XXX"
      return ["Player wins!", line]
      break
    elsif marks == "OOO"
      return ["Computer wins!", line]
      break
    end
  end
  nil
end

# check whether the game board is full
def board_full?(board)
  empty_board = board.select {|number, mark| mark.empty?}
  if empty_board.empty?
    "Board is full!"
  end
end

# main loop
begin

  board, player_arr, computer_arr = initialize_game(board, player_arr, computer_arr)

  # draw the empty board when game initialization
  draw_board(board, player_arr, computer_arr)

  # one game loop
  loop do
    player_pick_number = player_picks(board, player_arr)
    draw_board(board, player_arr, computer_arr)
    break if win?(board) || board_full?(board)

    computer_picks(board, computer_arr)
    draw_board(board, player_arr, computer_arr)
    break if win?(board) || board_full?(board)
  end

  if result = win?(board)
    puts "#{result[0]} winning line is: #{result[1]} "
  elsif result = board_full?(board)
    puts "#{result}" if result = board_full?(board)
  end

  print "Play again?(y/n)"

end until gets.chomp.downcase != 'y'

puts "Game Over!"
