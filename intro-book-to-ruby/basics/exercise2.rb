number = 7268
thousands = number / 1000
hundreds = number % 1000 / 100
tens = number % 1000 % 100 / 10
ones = number % 1000 % 100 % 10
puts "#{number}'s thousands number is #{thousands}, hundreds number is #{hundreds}, tens number is #{tens}, ones number is #{ones}. "