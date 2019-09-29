class ProfilesIngredient < ActiveRecord::Base 
    belongs_to :profile
    belongs_to :ingredient 
end 