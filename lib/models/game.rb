class Game < ActiveRecord::Base
    has_many :players
    has_many :boards, through: :players

    # add method for player to submit board, which will check solutions, and set end_time, and calculate total_time

    @@all = []

    def initialize(board, player, start_time)
        @board = board
        @player = player
        start_time = Time.now
        @@all << self
    end

    def self.all
        @@all
    end
    
        

end
