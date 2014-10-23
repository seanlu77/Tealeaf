words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

result = {}

words.each do |word|
	word_key = word.split('').sort.join.to_sym
	if result.has_key?(word_key)
		result[word_key] << word
	else
		result[word_key] = []
		result[word_key] << word
	end
end

result.each {|k, v| p v}

