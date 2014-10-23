a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

new_a = a.map! {|s| s.split(' ')}

p new_a

p new_a.flatten!
