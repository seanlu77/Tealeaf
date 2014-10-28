def say(msg)
	puts "=>#{msg}"
end

def exit_with(msg)
	puts "#{msg}"
	exit
end

def get_wores_from_file(file_name)
	if !File.exists?(file_name)
		say("#{file_name} not exists!")
		return
	end
	File.open(file_name, 'r') do |f|
		f.read
	end.split

end

exit_with("no input file!") if ARGV.empty?
exit_with("file doesn't exist!") if !File.exists?(ARGV[0])

contents = File.open(ARGV[0], 'r') do |f|
	f.read
end

nouns = get_wores_from_file('nouns.txt')
verbs = get_wores_from_file('verbs.txt')
adjectives = get_wores_from_file('adjectives.txt')

dictionary = {noun: nouns, verb: verbs, adjective: adjectives}

contents.gsub!('NOUN').each do |noun|
	dictionary[:noun].sample
end

contents.gsub!('VERB').each do |verb|
	dictionary[:verb].sample
end

contents.gsub!('ADJECTIVE').each do |adjective|
	dictionary[:adjective].sample
end

p contents

