require 'pry'

# initialize cards_in_decks, cards_of_player&dealer,
def initialize_game(number_of_decks)
  cards_in_decks = []
  cards_of_player = Array.new
  cards_of_dealer = Array.new
  suites = ["\u2660", "\u2663", "\u2665", "\u2666"]
  ranks = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  cards_in_decks = ranks.product(suites)*number_of_decks

  return [cards_in_decks.shuffle, cards_of_player, cards_of_dealer]
end

# deal cards 
def deal_cards(cards_in_decks, cards_in_hands)
  cards_in_hands.push(cards_in_decks.pop)
end

# calculate cards points in hands
def calculate_points(cards_in_hands)
  points = 0
  cards_without_ace = cards_in_hands.select {|card| card[1] != 'A'}
  cards_with_ace = cards_in_hands.select {|card| card[1] == 'A'}
  cards_without_ace.each do |card|
    if card[0].to_i !=0
      points += card[0].to_i
    else
      points += 10
    end
  end
  if cards_with_ace.empty?
    return points
  else
    ace_sets = [11, 1].repeated_permutation(cards_with_ace.length).to_a
    ace_sets_sum_arr = []
    ace_sets.each do |arr|
      arr_sum = 0
      arr.each {|v| arr_sum = arr_sum + v}
      ace_sets_sum_arr.push(arr_sum)
    end
    ace_sets_sum_arr.sort!.uniq!
    ace_sets_sum_arr.map! {|num| num + points}
    if ace_sets_sum_arr.include?(21)
      points = 21
      return points
    else
      lt_21_arr = ace_sets_sum_arr.select {|v| v < 21}
      gt_21_arr= ace_sets_sum_arr.select {|v| v > 21}
      if lt_21_arr.empty?
        points = gt_21_arr.first
        return points
      else
        points = lt_21_arr.last
        return points
      end
    end
  end
end

# display cards in hands
def display_hands(cards_of_player, cards_of_dealer, player_name, hidden)
  system 'clear'
  print "#{player_name}:\t"
  cards_of_player.each {|card| print card.join + '  '}
  puts "\t\tPoints: #{calculate_points(cards_of_player)}"
  puts
  print "Dealer:\t"
  cards_of_dealer.each_with_index do |v, index|
    if !hidden || index == 0
      print v.join + '  '
    else
      print "??" + '  '
    end
  end

  print "\t\tPoints: #{calculate_points(cards_of_dealer)}" if !hidden
  puts
  puts
end

# calculate both player and dealer's cards points 
def calculate_total(cards_of_player, cards_of_dealer)
  total_points=[]
  total_points[0] = calculate_points(cards_of_player)
  total_points[1] = calculate_points(cards_of_dealer)
  total_points
end

# check winner, return result message and counting winning times
def display_winner(total_points, player_name, wins)
  if total_points[0] > 21
    wins[1] += 1
    msg = "#{player_name} busted, Dealer wins!!"
  elsif total_points[1] > 21
    wins[0] += 1
    msg = "Dealer busted, #{player_name} wins!!"
  elsif total_points[0] > total_points[1]
    wins[0] += 1
    msg = "#{player_name} wins, dealer lost!!"
  elsif total_points[0] < total_points[1]
    wins[1] += 1
    msg = "Dealer wins, #{player_name} lost!!"  
  else
    msg = "It's a tie!!"
  end
  puts msg
  puts
  puts
  puts "#{player_name} wins: #{wins[0]}\tDealer wins: #{wins[1]}"
end

puts "Blackjack game running ......"
print "What's your name?"
player_name = gets.chomp
print "How many decks?"
number_of_decks = gets.chomp.to_i
wins = [0, 0]

loop do

  cards_in_decks, cards_of_player, cards_of_dealer = initialize_game(number_of_decks)

  # deal 2 cards to each one
  2.times do
    deal_cards(cards_in_decks, cards_of_player)
    deal_cards(cards_in_decks, cards_of_dealer)
  end

  #player's turn

  stay = false
  while calculate_points(cards_of_player) <= 21 && !stay
    display_hands(cards_of_player, cards_of_dealer, player_name, true)
    begin
      print "hit or stay?(h/s)"
      answer = gets.chomp.downcase
    end until ['h', 's'].include?(answer)

    if answer == 'h'
      deal_cards(cards_in_decks, cards_of_player)
    else
      stay = true
    end 
  end

  #dealer's turn
  if stay
    while calculate_points(cards_of_dealer) < 17
      deal_cards(cards_in_decks, cards_of_dealer)
    end
  end
  
  total_points = calculate_total(cards_of_player, cards_of_dealer)
  display_hands(cards_of_player, cards_of_dealer, player_name, false)
  display_winner(total_points, player_name, wins)

  puts
  puts

  print "play again?(y/n): "
  if gets.chomp.downcase != 'y'
    puts "Game Over!"
    break
  end
end 