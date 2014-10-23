# prompt the user to enter number
def say(msg)
  print "=> #{msg}"
end

def reply(msg)
  puts "---- #{msg}"
end

#judge the number inputed whether valid
def is_number?(num)
  return true if num == '0' || num.to_i != 0
end

#prompt the user until a valid number is entered
def get_number
  begin
    number = gets.chomp
    puts "#{number} is not a valid number!" unless is_number?(number)
  end until is_number?(number)
  return number
end

say"please enter number 1: "
number1 = get_number
reply("number 1 is #{number1}")

say("please enter number 2: ")
number2 = get_number
reply("number 2 is #{number2}")

begin
  say("please choose the operator: (1 - add, 2 - subtract, 3 - multiply, 4 - divide): ")
  operator = gets.chomp
end until ['1', '2', '3', '4'].include?(operator)

case operator
  when "1"
    result = number1.to_f + number2.to_f
    operator_name = "add"
    operator_mark = "+"
  when "2"
    result = number1.to_f - number2.to_f
    operator_name = "subtract"
    operator_mark = "-"
  when "3"
    result = number1.to_f * number2.to_f
    operator_name = "multiply"
    operator_mark = "*"
  when "4"
    if number2.to_i == 0
      puts "zero can not be divided!"
    else
      result = number1.to_f / number2.to_f
    end
    operator_name = "divide"
    operator_mark = "/"
end

reply("the operator is #{operator_name}")

puts "------------------------------------"
puts " the result is: #{number1} #{operator_mark} #{number2} = #{result}"
