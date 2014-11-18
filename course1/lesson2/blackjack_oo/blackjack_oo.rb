require 'pry'
module Blackjack

  def points
    points = 0
    cards_without_a = cards.select {|card| card.value != 'A'}
    cards_without_a.each do |card|
      if card.value.to_i != 0
        points += card.value.to_i
      elsif card.value != 'A'
        points += 10
      end
    end
    cards_with_a = cards.select {|card| card.value == 'A'}
    cards_with_a.size.times do 
      points += 11
      points -= 10 if cards_with_a.size > 1 && points == Game::BLACKJACK_AMOUNT || points > Game::BLACKJACK_AMOUNT
    end
    points
  end

  def show_hand
    puts self
  end

end

class Player 
  include Blackjack

  attr_accessor :name, :cards, :wins, :hit_or_stay

  def initialize(n)
    @name = n
    @cards = []
    @wins = 0
    @hit_or_stay = ''
  end

  def to_s
    "#{self.name}:  #{self.cards.join(' ')}      points: #{self.points}"
  end

end

class Dealer
  include Blackjack

  attr_accessor :cards, :wins
  def initialize
    @cards = []
    @wins = 0
  end

  def to_s
    "dealer: #{self.cards.join(' ')}     points: #{self.points}"
  end

end

class Card
  attr_accessor :value, :suit

  def initialize(v, s)
    @value = v
    @suit = s
  end

  def to_s
    "#{value}#{suit}"
  end

end

class Deck
  FACES = [ "A", "2", "3", "4", "5", "6", "7", "8", "9" ,"10", "J", "Q", "K"]
  SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"]

  attr_accessor :card, :value, :num_of_decks
  def initialize(num=1)
    @value = []
    @num_of_decks = num
    (FACES.product(SUITS)*num).shuffle.each do |c|
      @card = Card.new(c[0], c[1])
      @value.push(@card)
    end
  end

  def deal_card(player)
    player.cards.push(@value.pop)
  end

  def deal_2_cards_each(player1, player2)
    2.times do
      deal_card(player1)
      deal_card(player2)
    end
  end
end

class Game
  attr_accessor :player, :dealer, :deck, :result
  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    @deck = Deck.new
    @player = Player.new("sean")
    @dealer = Dealer.new
    @result = ''
  end

  def start_game
    puts "What's your name?"
    print "=>"
    player.name = gets.chomp
    puts "How many decks do you want?"
    print "=>"
    deck.num_of_decks = gets.chomp.to_i
    deck = Deck.new(self.deck.num_of_decks)
  end

  def clear_deck
    player.cards.clear
    dealer.cards.clear 
    deck = Deck.new(self.deck.num_of_decks)
  end

  def display_players
    system 'clear'
    puts player
    puts dealer
    puts 
  end

  def display_winner(message, wins1, wins2)
    puts message
    puts "#{player.name} wins: #{wins1}\tdealer wins: #{wins2}"
  end

  def player_play
    begin
      while true
        puts "Player chooses Hit or Stay (h/s)?"
        print '=>'
        player.hit_or_stay = gets.chomp.downcase
        break if player.hit_or_stay == 'h' || player.hit_or_stay == 's'
      end
      break if player.hit_or_stay == 's'
      deck.deal_card(player)
      display_players
    end until player.points > BLACKJACK_AMOUNT
    if player.points > BLACKJACK_AMOUNT 
      @result = "#{player.name} busted! Dealer wins!"
      dealer.wins += 1
    elsif player.points == BLACKJACK_AMOUNT
      @result = "#{player.name} hits the blackjack, #{player.name} wins!"
      player.wins += 1
    end
  end

  def dealer_play
    while dealer.points < DEALER_HIT_MIN
      deck.deal_card(dealer)
      display_players
    end
    if dealer.points > BLACKJACK_AMOUNT
      @result = "Dealer busted! #{player.name} wins!"
      player.wins += 1
    elsif dealer.points == BLACKJACK_AMOUNT
      @result = "Dealer hits the blackjack, dealer wins!"
      dealer.wins += 1
    else
      return
    end
  end

  def who_win?
    if dealer.points < player.points
      @result = "#{player.name} wins!"
      player.wins += 1
    elsif dealer.points == player.points
      @result = "It's a tie!"
    else
      @result = "Dealer wins!"
      dealer.wins += 1
    end
  end

  def run
    start_game
    while true
      clear_deck
      deck.deal_2_cards_each(player, dealer)
      display_players
      player_play
      dealer_play if player.hit_or_stay == 's'
      who_win? if player.points < 21 && dealer.points < 21
      display_winner(result, player.wins, dealer.wins)
      puts "Play again?(y/n)"
      exit if gets.chomp.downcase != 'y'
    end
  end

end

Game.new.run
