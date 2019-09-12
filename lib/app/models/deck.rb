class Deck
    attr_reader :cards, :community_hand

    def initialize
        @cards = []
        for suit in ["♥", "♣", "♦", "♠"] do
          for rank in ["A", "2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K"] do
            @cards << rank+suit
          end
          @community_hand = []
        end
    end

    def flop
        card1 = @cards.delete_at(rand(@cards.length))
        card2 = @cards.delete_at(rand(@cards.length))
        card3 = @cards.delete_at(rand(@cards.length))
     community_hand << card1
     community_hand << card2
     community_hand << card3
     community_hand
    end

    def turn_or_river
        turn_card = @cards.delete_at(rand(@cards.length))
        community_hand << turn_card
        community_hand
    end

    def deal_cards
        card1 = @cards.delete_at(rand(@cards.length))
        card2 = @cards.delete_at(rand(@cards.length))
        [card1, card2]
    end

    def map_cards_to_ranks(array)
        array.map do |card|
            if card[1] == "♥"
             card["♥"] = "#{card[0]}H"
            elsif card[1] == "♣"
             card["♣"] = "#{card[0]}C"
            elsif card[1] == "♦"
                card["♦"] = "#{card[0]}D"
            elsif card[1] == "♠"
                card["♠"] = "#{card[0]}S"
            end
        end

    end

end