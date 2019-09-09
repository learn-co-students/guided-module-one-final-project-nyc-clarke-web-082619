class Player < ActiveRecord::Base
    has_many :games
    has_many :boards, through: :games


    @@all = []

    def initialize(name)
        @name = name
        @@all << self
    end

    def self.all
        @@all
    end

end