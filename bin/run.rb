require_relative '../config/environment'
require_relative '../lib/app/models/user'
require_relative '../lib/app/models/deck'


puts "Welcome to texas-holdem poker."
prompt = TTY::Prompt.new
isPlaying =true
user = User.new
prompt.keypress("You have #{user.wallet}. Press any key to continue.")

while isPlaying
    deck = Deck.new
    user_hole_cards = deck.deal_cards
    computer_hole_cards = deck.deal_cards
    print user_hole_cards
    # prompt = TTY::Prompt.new
    user_selection = prompt.select("Bet 10 or fold?", %w(Bet Fold))
    if user_selection == "Bet"
        puts "Your current wallet amount : #{user.bet}. Your current bet is #{user.current_bet}."
        print deck.flop
        puts "Your cards: #{user_hole_cards}"
        user_selection2 = prompt.select("Bet 10 or fold?", %w(Bet Fold))
        if user_selection2 == "Bet"
            puts "Your current wallet amount : #{user.bet}. Your current bet is #{user.current_bet}."
            #user.bet 
            print deck.turn_or_river
            puts "Your cards: #{user_hole_cards}"
            user_selection3 = prompt.select("Bet 10 or fold?", %w(Bet Fold))
            if user_selection3 == "Bet"
                puts "Your current wallet amount : #{user.bet}. Your current bet is #{user.current_bet}."
                #user.bet 
                print deck.turn_or_river
                community_hand = deck.community_hand
                puts "Computer's hole cards: #{computer_hole_cards}"
                puts "Your cards: #{user_hole_cards}."
                community_hand = deck.map_cards_to_ranks(community_hand)
                user_hole_cards = deck.map_cards_to_ranks(user_hole_cards)
                computer_hole_cards = deck.map_cards_to_ranks(computer_hole_cards)
                computer_hand = PokerHand.new(computer_hole_cards.concat(community_hand))
                user_hand = PokerHand.new(user_hole_cards.concat(community_hand))
                puts "The computer has #{computer_hand.rank}."
                puts "You have #{user_hand.rank}"
                if user_hand > computer_hand
                    user.wallet += user.current_bet * 2
                    puts "You won!"
                    puts "You have #{user.wallet}."
                    user.current_bet = 0
                else
                    puts "You lost!"
                    puts "You have #{user.wallet}."
                    user.current_bet = 0
                    if user.wallet < 30
                        puts "You're out of money. Thanks for playing!"
                        isPlaying = false
                    end
                end

            else
            puts "Thanks for playing!"
            isPlaying = false
            end
        else
            puts "Thanks for playing!"
            isPlaying = false
        end

    else
        puts "Thanks for playing!"
        isPlaying = false
    end

end


