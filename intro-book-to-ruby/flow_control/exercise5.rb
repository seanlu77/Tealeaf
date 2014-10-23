def evaluate_num(number)
	if ( number < 0 )
		puts "#{number} is less than 0"
	elsif ( number <= 50)
		puts "#{number} is between 0 and 50"
	elsif ( number <= 100)
		puts "#{number} is between 50 and 100"
	else
		puts "#{number} is above 100"
	end
end

def evaluate_case1_num(number)
	case 
	when ( number > 0) && ( number <= 50 )
		puts "#{number} is between 0 and 50"
	when ( number > 50) && ( number <= 100 )
		puts "#{number} is between 50 and 100"
	when ( number > 100)
		puts "#{number} is above 100"
	end
end

def evaluate_case2_num(number)
	case number
	when 0..50
		puts "#{number} is between 0 and 50"
	when 51..100
		puts "#{number} is between 50 and 100"
	else 
		if number < 0
			puts "the number is less than 0"
		else
			puts "#{number} is above 100"
		end
	end
end

		
puts "please enter a number between 0 and 100:"
number = gets.chomp.to_i

evaluate_num(number)
evaluate_case1_num(number)
evaluate_case2_num(number)