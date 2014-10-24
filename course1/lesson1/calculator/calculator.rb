puts "Calculator is running ......"

# validate the input 
def validate_number?(num)
  if num == "0" || num.to_i != 0 
    return true
  else
    return false
  end
end

# get the number  
def get_number
  begin
    number = gets.chomp
    puts "It's not a number! input again: " unless validate_number?(number)
  end until validate_number?(number)
  return number
end

# get the operator
def get_operator
  op_arr = ['+', '-', '*', '/']
  begin
    operator = gets.chomp
    puts "It's not a valid op, choose from #{op_arr}." unless op_arr.include?(operator)
  end until op_arr.include?(operator)
  return operator
end

# do the math
def do_math(num1, num2, op)
  case op
  when '+'
    num1.to_f + num2.to_f
  when '-'
    num1.to_f + num2.to_f
  when '*'
    num1.to_f * num2.to_f
  when '/'
    if num2 == '0'
      puts "zero can not be divided!"
    else
      num1.to_f / num2.to_f
    end
  end
end

# main loop
begin
  
  puts "number 1: "
  number1 = get_number
  
  puts "number 2: "
  number2 = get_number

  puts "choose operator '+ - * /': "
  operator = get_operator

  result = do_math(number1, number2, operator)

  puts "#{number1} #{operator} #{number2} = #{result}"

  puts "Do you want to do another calculate?(Y/N)"
  if ['y', 'Y'].include?(gets.chomp)
    cal_over = false
  else
    cal_over = true
  end

end until cal_over

puts "Calculator is off."