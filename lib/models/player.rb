class Player < ActiveRecord::Base
    has_many :games
    has_many :boards, through: :games

    def self.find_by_name
    end
    
end