class Board < ActiveRecord::Base
    belongs_to :game
    belongs_to :player

    @@all = []

    def initialize(puzzle, solution) #add difficulty
        @puzzle = puzzle
        @solution = solution
        @@all << self
    end

    def self.all
        @@all
    end
    

end