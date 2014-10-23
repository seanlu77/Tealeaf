def caps(s)
	if s.length > 10
		s.upcase
	else
		s
	end
end

puts caps("hello,world!")
puts caps("haha")
puts caps("please raise your hands up!")