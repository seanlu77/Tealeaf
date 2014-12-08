require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

BLACKJACK_AMOUNT = 21
DEALER_MIN_HIT = 17

helpers do

  def calculate_points(cards)
    points = 0
    cards_without_a = cards.select {|card| card[1] != 'A'}
    cards_without_a.each do |card|
      if card[1].to_i != 0
        points += card[1].to_i
      elsif card[1] != 'A'
        points += 10
      end
    end
    cards_with_a = cards.select {|card| card[1] == 'A'}
    cards_with_a.size.times do 
      points += 11
      points -= 10 if cards_with_a.size > 1 && points == 21 || points > 21
    end
    points
  end

  def find_pic_url(card)
    pic_name = case card[0]
    when 'H'
      'hearts_' + card[1] + '.jpg'
    when 'D'
      'diamonds_' + card[1] + '.jpg'
    when 'C'
      'clubs_' + card[1] + '.jpg'
    when 'S'
      'spades_' + card[1] + '.jpg'
    end
    pic_url = "<img src=/images/cards/#{pic_name} class='card_pic'>"
  end

end

before do
  @show_hit_or_stay_btn = true
  @player_stay = false
  @get_result = false
  @show_dealer_hit_button = false
end

get '/' do
  erb :main
end

get '/entry' do
  if session[:player_name]
    redirect '/game'
  else
    redirect '/new_player'
  end
end

get '/new_player' do
  session[:money] = 500
  erb :new_player
end

post '/new_player' do
  if params[:player_name].empty?
    @error = "Name is required!"
    halt erb(:new_player)
  end

  session[:player_name] = params[:player_name]
  redirect '/bet'
end

get '/bet' do
  erb :bet
end

post '/bet' do
  session[:bet_number] = params[:bet_number]
  redirect '/game'
end

get '/game' do
  session[:turn] = session[:player_name]
  suits = ['H', 'D', 'C', 'S']
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'jack', 'queen', 'king', 'ace']
  session[:deck] = suits.product(values).shuffle!
  session[:player_cards] = []
  session[:dealer_cards] = []
  session[:player_cards] << session[:deck].pop
  session[:dealer_cards] << session[:deck].pop
  session[:player_cards] << session[:deck].pop
  session[:dealer_cards] <<  session[:deck].pop
  erb :game
end

post  '/game/player/hit' do
  session[:player_cards] << session[:deck].pop
  if calculate_points(session[:player_cards]) > BLACKJACK_AMOUNT
    @error = "Sorry, #{session[:player_name]} busted! Dealer wins!"
    @show_hit_or_stay_btn = false
    @get_result = true
    session[:money] -= session[:bet_number].to_i
  elsif calculate_points(session[:player_cards]) == BLACKJACK_AMOUNT
    @success = "#{session[:player_name]} hit the Blackjack! #{session[:player_name]} wins!"
    @show_hit_or_stay_btn = false
    @get_result = true
    session[:money] += session[:bet_number].to_i
  end
  erb :game
end

post '/game/player/stay' do
  redirect '/game/dealer'
end

get '/game/dealer' do
  session[:turn] = 'dealer'
  @player_stay = true
  @show_hit_or_stay_btn = false
  dealer_total = calculate_points(session[:dealer_cards])
  if dealer_total == BLACKJACK_AMOUNT
    @error = "Dealer wins! Dealer hits the Blackjack!"
    @show_hit_or_stay_bt = false
    @get_result = true
    session[:money] -= session[:bet_number].to_i
    erb :game
  elsif dealer_total > BLACKJACK_AMOUNT
    @success = "Dealer busted! #{session[:player_name]} wins!"
    @show_hit_or_stay_btn = false
    @get_result = true
    session[:money] += session[:bet_number].to_i
    erb :game
  elsif dealer_total < DEALER_MIN_HIT
    @show_dealer_hit_button = true
    erb :game
  else
    redirect '/game/comparison'
  end
end

post '/game/dealer/hit' do
  session[:dealer_cards] << session[:deck].pop
  redirect '/game/dealer'
end

get '/game/comparison' do
  @show_hit_or_stay_btn = false
  @get_result = true
  @player_stay = true
  player_total = calculate_points(session[:player_cards])
  dealer_total = calculate_points(session[:dealer_cards])
  if player_total == dealer_total
    @success = "It a tie! Both #{session[:player_name]} and dealer stayed at #{player_total}"
  elsif player_total < dealer_total
    session[:money] -= session[:bet_number].to_i
    @error = "Dealer wins! #{session[:player_name]} stays at #{player_total}, dealer stays at #{dealer_total}."
  else
    session[:money] += session[:bet_number].to_i
    @success = "#{session[:player_name]} wins! #{session[:player_name]} stays at #{player_total}, dealer stays at #{dealer_total}."
  end
  erb :game
end

get '/game_over' do
  erb :game_over
end





