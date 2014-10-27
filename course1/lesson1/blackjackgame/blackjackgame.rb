#1.initialy, player dealt with 2 cards randomly, dealer dealt with 2 cards randomly.
#2.player choose "hit" to be dealt with new card, deal_card()
#2.1 player_cards.push(new_card), if player_cards_sum > 21, player "busted" and "player lost"
#2.2 if player_cards_sum = 21, player "win"
#2.3 if player_cards_sum < 21, player can choose "hit" or "stay"
#3 if player choose "stay", dealer goes
#3.1 while dealer_cards_sum < 17, dealer must "hit", dealt with new cards
#3.2 if dealer_cards_sum >21, dealer "busted", "player win"
#3.2 if dealer_cards_sum = 21, dealer win!
#3.3 if dealer stay, do_compare(player_cards_sum, dealer_cards_sum), higher value win


cards = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
         'J' => 10, 'Q' => 10, 'K' => 10, 'A_high' => 10, 'A_low' => 10}

cards_package = []      #一副牌

player_cards = []   # track cards dealt to player
dealer_cards = []   # track cards dealt to dealer

player_cards_sum

def deal_card(cards, player_cards)
  player_cards.push(new_card)


# array elements 随机重排，返回一个new array
[].shuffle

初始化，洗牌

每人发两张牌
check player 是否21，如果是，天成，win！
check dealer 是否21，如果是，天秤，win！
如果都是，tie！

player 玩牌进程

loop do
  ask 'hit/stay?'
  if hit
    deal_card()
    check "busted" or "21"
    if "busted" return "lost" end
    if "21" return "win" end
  elsif stay
    break 进入 dealer process
  end
end

dealer 玩牌进程

loop do
  检查dealer牌的和，如果<17
  while sum<17
    deal_card()
    检查牌和，如果爆掉，break，lost；
             如果21，break， win；
  end
  询问 ‘hit/stay?'
  if stay, 比较 player和dealer的牌和，大者胜


    
  end