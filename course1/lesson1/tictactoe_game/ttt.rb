#1. draw chess board
#1.1 def draw_board(b) end
#1.2 定义棋盘的数据结构，在array和hash中选择，需要编号，但是否有序无所谓，
#2. player picks a square, put a "X" on the board, check to see whether win or board is empty.
#2.1 在棋盘的数据结构中标记，表示player落子；判断是否与已占用的格子重复，loop；
#2.2 单独的数据结构，记录player所有的落子，内容是落子的位置即编号？
#2.3 put a 'X' on the board, 调用方法 draw_board()
#2.4 检查是否有输赢，调用方法 is_win?();如果是，退出loop，输出结果
#2.5 检查棋盘的格子是否全被占用，调用方法 is_taken?()；如果是，退出loop，输出结果
#3. computer picks a square randomly, puts a "O" on the board, check to see whether win or board is empty.
#3.1 为计算机随机选择一个棋盘位置，需要从剩下来的格子中选择，
#4. loop the steps above until WIN or square all taken.
#5. output the game result.

#表现棋盘的数据结构, 包含9个元素的队列，对应棋盘的9个空格，初始化为每个元素为''
#chess_board = Array.new(9, '') 

# use a hash to represent the chess board, keys are number from "1" - "9", value are initialized to ''
chess_board = { "1" => '', "2" => '', "3" => '',
                "4" => '', "5" => '', "6" => '',
                "7" => '', "8" => '', "9" => ''
              }

#表现赢棋情况的数据结构，赢棋情况的所有编号组合, all combinations of win chess scenario
win_chess_senario = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], 
                      [2,5,8], [3,6,9], [1,5,9], [3,5,7] ]



#画棋盘方法, b is the data structure representing the chess board
def draw_board(b)
  system("clear")
  puts " #{b["1"]}   |  #{b["2"]}  |  #{b["3"]}  "
  puts "----------------"
  puts " #{b["4"]}   |  #{b["5"]}  |  #{b["6"]}  "
  puts "----------------"
  puts " #{b["7"]}   |  #{b["8"]}  |  #{b["9"]}  "
end

# 判断输赢,传入chess_board和win_chess_senario作为参数, 返回满足赢棋条件的组合array，如［1，2，3］
# b => chess_board hash, s => win_chess_senario, square_number => number of the chess board square
def win?(b, s)
  s.each do |line|
    mark_str = ''
    line.each do |square_number|
      mark_str << b[square_number.to_s].to_s
    end
    if mark_str == "XXX"
      return [line, "player win!"]
      break
    elsif mark_str == "OOO"
      return [line, "computer win!"]
      break
    end
  end
  return false
end

# check the chess board whether empty
def is_full?(b)
  is_full = true
  b.each do |k, v|
    if v.empty? 
      is_full = false
      break
    end
  end
  return is_full
end

# check the square whether taken, return true if the square is taken.
def is_taken?(b, p)
  return true if ["X", "O"].include?(b[p])
end


#playe choose the square by number, return the square number
def get_player_select(b)
  begin
    player = gets.chomp
    puts "It's already taken!" if is_taken?(b, player)
  end until !is_taken?(b, player)
  return player
end

# computer choose from the empty squares , and randomly select one, return the square number; 
# computer在没有被占用的棋格中，随机选择棋格，返回选中的棋格编号
def get_computer_select(b)
  b_not_taken = b.select {|k, v| v.empty?}
  b_not_taken.keys.sample
end

def display_result(b, s)
  puts "the win line is => " + win?(b,s)[0].to_s if win?(b,s)
end

#main loop of the game
begin
  puts "Choose a position, 1 - 9: "
  player_select = get_player_select(chess_board)
  chess_board[player_select] = "X"
  draw_board(chess_board)

  #检验有无输赢的结果，有就退出main loop
  # check whether win, if win then output the result and quit the main loop
  winner = win?(chess_board, win_chess_senario)
  if winner 
    puts winner[1]
    break
  end

  if is_full?(chess_board)
    puts "the chess board is full!"
    break
  end

  computer_select = get_computer_select(chess_board)
  puts "computer chose #{computer_select}"
  chess_board[computer_select] = "O"
  draw_board(chess_board)

  #检验有无输赢结果，有就退出main loop
  # check whether win, if win then output the result and quit the main loop
  winner = win?(chess_board, win_chess_senario)
  if winner 
    puts winner[1]
    break
  end

  if is_full?(chess_board)
    puts "the chess board is full!"
    break
  end
  
end until win?(chess_board, win_chess_senario)

display_result(chess_board, win_chess_senario)



