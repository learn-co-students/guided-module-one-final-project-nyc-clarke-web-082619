class Profile < ActiveRecord::Base 
    has_many :profiles_ingredients
    has_many :profiles_recipes
    has_many :recipes, through: :profiles_recipes
    has_many :ingredients, through: :profiles_ingredients
end 