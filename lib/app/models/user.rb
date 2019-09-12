class User 
    attr_accessor :wallet, :current_bet
    
        def initialize
            @wallet = 100
            @current_bet = 0
        end
    
        def bet
            @wallet -= 10
            @current_bet += 10
            return wallet
        end
    
    end