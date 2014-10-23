person = {height: '6 ft', weight: '160 lbs'}

new_person = {:hair=>'brown', :name=>'bob'}

puts "using merge method"
p person.merge(new_person)
p person
p new_person

puts "using merge! method"
p person.merge!(new_person)
p person
p new_person

