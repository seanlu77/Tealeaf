# player
require 'pry'
module Blackjack
  def cal_points(cards)
    points = 0
    cards_without_a = cards.select {|card| card[0] != 'A'}
    cards_without_a.each do |card|
      if card[0].to_i != 0
        points += card[0].to_i
      elsif card[0] != 'A'
        points += 10
      end
    end
    cards_with_a = cards.select {|card| card[0] == 'A'}
    cards_with_a.size.times do 
      points += 11
      points -= 10 if cards_with_a.size > 1 && points == 21 || points > 21
    end
    points
  end
end

class Player 
  include Blackjack

  @@wins = 0
  attr_reader :name
  attr_accessor :cards, :wins

  def initialize(n)
    @name = n
    @cards = []
    @wins = 0
  end

  def points
    self.cal_points(self.cards)
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

  def points
    self.cal_points(cards)
  end

  def to_s
    "dealer: #{self.cards.join(' ')}     points: #{self.points}"
  end

end

class Decks
  FACES = [ "A", "2", "3", "4", "5", "6", "7", "8", "9" ,"10", "J", "Q", "K"]
  SUITS = ["\u2660", "\u2663", "\u2665", "\u2666"]

  def initialize(number_of_deck)
    @value = (FACES.product(SUITS)*number_of_deck).shuffle
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
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new("sean")
    @dealer = Dealer.new
    @deck = Decks.new(2)
  end

  def start_game
    player.cards.clear
    dealer.cards.clear 
    @deck = Decks.new(2)
  end

  def display_players
    system 'clear'
    puts player
    puts dealer
    puts 
  end

  def display_winner(msg, wins1, wins2)
    puts msg
    puts "#{player.name} wins: #{wins1}\tdealer wins: #{wins2}"
  end

  def player_play
    begin
      while true
        puts "Player chooses Hit or Stay (h/s)?"
        print '=>'
        hit_or_stay = gets.chomp.downcase
        break if hit_or_stay == 'h' || hit_or_stay == 's'
      end
      return if hit_or_stay == 's'
      deck.deal_card(player)
      self.display_players
    end until player.points > 21
  end

  def dealer_play
    while dealer.points < 17
      deck.deal_card(dealer)
      self.display_players
    end
  end

  def run
    while true
      start_game
      deck.deal_2_cards_each(player, dealer)
      self.display_players
      self.player_play
      if player.points > 21 
        msg = "#{player.name} busted! Dealer wins!"
        dealer.wins += 1
      elsif player.points == 21
        msg = "#{player.name} wins!"
        player.wins += 1
      else
        self.dealer_play
        if dealer.points > 21
          msg = "Dealer busted! #{player.name} wins!"
          player.wins += 1
        elsif dealer.points == 21
          msg = "Dealer wins!"
          dealer.wins += 1
        elsif dealer.points < player.points
          msg = "#{player.name} wins!"
          player.wins += 1
        elsif dealer.points == player.points
          msg = "It's a tie!"
        else
          msg = "Dealer wins!"
          dealer.wins += 1
        end
      end
      display_winner(msg, player.wins, dealer.wins)
      puts "Play again?(y/n)"
      break if gets.chomp.downcase != 'y'
    end
  end

end

Game.new.run
