class Party < ActiveRecord::Base
    belongs_to :host
    has_many :attendances
    has_many :guests, through: :attendances

    def view_my_party
        party_hash = {}
        party_hash[:name] = self.name
        puts self
    end

end