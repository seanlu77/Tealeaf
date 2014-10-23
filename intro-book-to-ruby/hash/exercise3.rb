person = {name: 'bob', height: '6 ft', weight: '160 lbs', hair: 'brown'}

puts "all the key"
person.each_key do |k|
	puts k
end
puts
puts "all the value"
person.each_value do |v|
	puts v
end

puts
puts "all the value and key"
person.each do |k, v|
	puts "#{k} => #{v}"
end

