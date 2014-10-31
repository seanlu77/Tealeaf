
def valid_number?(number)
	if number == '0' || number.to_i != 0
		number
	else
		nil
	end
end

def get_number(msg)
	while true
		puts "Input #{msg}:"
		print "=>"
		number = gets.chomp
		if !valid_number?(number)
			puts "it's not a valid number!"
		else
			break
		end
	end
	number
end

def get_op
	while true
		puts "Input operator ( + - * / ): "
		print "=>"
		op = gets.chomp
		if ['+', '-', '*', '/'].include?(op)
			break
		else
			puts "not a valid operator"
		end
	end
	op
end

number1 = get_number("number1")
number2 = get_number("number2")
op = get_op

result = case op
when '+'
	number1.to_f + number2.to_f
when '-'
	number1.to_f - number2.to_f
when '*'
	number1.to_f * number2.to_f
when '/'
	if number2 == '0'
		puts "zero can't be divided!"
	else
		number1.to_f / number2.to_f
	end
end

puts "#{number1} #{op} #{number2} = #{result}"
