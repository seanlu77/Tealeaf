contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

field = [:email, :address, :phone]

contact_data.each do |person|
	contacts.each do |name, info|
		info[field] = person.shift
	end
end

p contacts