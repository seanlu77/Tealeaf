puts "play prs game!"

choices = ['p', 'r', 's']

loop do 

  begin
    puts "choose one (p/r/s): "
    player = gets.chomp.downcase
  end until choices.include?(player)

  computer = choices.sample

  case player
  when 'p'
    if computer == 'p'
      puts "it's a tie!"
    elsif computer == 'r'
      puts "you win! paper smash rock!"
    else
      puts "you lost! scissors cut paper!"
    end
  when 'r'
    if computer == 'p'
      puts "you lost! paper smash rock!"
    elsif computer == 'r'
      puts "it's a tie!"
    else
      puts "you win! rock smash scissors!"
    end
  when 's'
    if computer == 'p'
      puts "you win! scissors cut paper!"
    elsif computer == 'r'
      puts "you lost! rock smashes scissors!"
    else
      puts "it's a tie!"
    end
  end

  puts "play again? (y/n):" 
  break if gets.chomp.downcase != 'y'
end

puts "Game over, good bye!"
        
