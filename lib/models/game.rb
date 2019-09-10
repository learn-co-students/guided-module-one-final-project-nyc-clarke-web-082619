class Game < ActiveRecord::Base
    has_many :players
    has_many :boards, through: :players



    # def check_user_input(input)
    #     if !(input >= 1 && <= 9)
    #         puts "Invalid entry, try again"
    #     else
    #         #run
    #     end
    # end

    # add method for player to submit board, which will check solutions, and set end_time, and calculate total_time

    # @@all = []

    # def initialize(board, player, start_time)
    #     @board = board
    #     @player = player
    #     start_time = Time.now
    #     @@all << self
    # end

    # def self.all
    #     @@all
    # end
    
        

end
