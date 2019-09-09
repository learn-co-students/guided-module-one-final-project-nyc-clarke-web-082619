class Ingredient < ActiveRecord::Base
    has_many :ingredients_recipes
    has_many :recipes, through: :ingredients_recipes

    def recipe_names
        recipes.map{|rec| rec.name}
    end

    def self.find_food(food)
        self.all.find_by(name: food)
    end

    def self.find_foods(food_array)
        new_array = []
        food_array.each do |food_name|
            new_array << self.find_food(food_name)
        end
        new_array
    end
end