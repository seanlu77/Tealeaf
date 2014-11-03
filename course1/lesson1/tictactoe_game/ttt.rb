WINNING_LINES = [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9'], ['1', '4', '7'], ['2', '5', '8'], ['3', '6', '9'], 
                 ['1', '5', '9'], ['3', '5', '7']]

def initialize_board
  b = {}
  ('1'..'9').each {|i| b[i] = ''}
  b
end

def draw_board(b)
  system 'clear'
  puts
  puts "     |     |"
  puts "  #{b['1']}  |  #{b['2']}  |  #{b['3']}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{b['4']}  |  #{b['5']}  |  #{b['6']}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{b['7']}  |  #{b['8']}  |  #{b['9']}"
  puts "     |     |"
  puts
 # puts "Player picks: #{player_arr}, Computer picks: #{computer_arr}"
end

def check_winner(b)
  WINNING_LINES.each do |line|
    return ["Player wins!", line] if b.values_at(*line).count('X') == 3
    return ["Computer wins!", line] if b.values_at(*line).count('O') == 3
  end
  nil
end

def two_in_a_row(b)
  WINNING_LINES.each do |line|
    str = ''
    line.each do |i|
      str << b[i]
    end
    return line.select {|i| b[i].empty?} if str == 'XX'
  end
  nil
end

def computer_pick(b)
  if two_in_a_row(b)
    return two_in_a_row(b)[0]
  else
    return empty_board(b).keys.sample
  end
end

def empty_board(b)
  b.select {|k, v| v.empty?}
end

def is_board_full?(b)
  return true if empty_board(b).empty?
end

def is_available?(b, pick)
  return true if b[pick].empty?
end

puts "Tic Tac Toe Game Starts!"
puts "what's your name?"
print '=>'
player_name = gets.chomp

while true

  board = initialize_board

  while true

    draw_board(board)

    while true
      puts "Pick one: (1 - 9)"
      print '=>'
      player_pick = gets.chomp
      if is_available?(board, player_pick)
        board[player_pick] = 'X'
        break
      end
    end

    draw_board(board)
    result = check_winner(board)
    break if is_board_full?(board) || result

    computer_pick = computer_pick(board)
    board[computer_pick] = 'O'
    draw_board(board)
    result = check_winner(board)
    break if is_board_full?(board) || result

  end

  if is_board_full?(board) && !result
    puts "It's a tie!"
  else
    puts "#{result[0]}, winning line is #{result[1]}"
  end

  puts "Play again? (y/n)"
  print '=>'
  break if gets.chomp != 'y'

end

puts "Game Over, Good Bye!"