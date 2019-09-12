class ProfilesRecipe < ActiveRecord::Base 
    belongs_to :profile 
    belongs_to :recipe 
end 