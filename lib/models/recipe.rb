class Recipe < ActiveRecord::Base
    has_many :ingredients_recipes
    has_many :ingredients, through: :ingredients_recipes

    def self.names_from_ingredient_array(ingredient_array)
        ingredient_array.map {|item| item.recipes.map{|rec| rec.name}}.flatten.uniq
    end

    def self.print_list_from_ingredient_array(ingredient_array)
        recipe_list = names_from_ingredient_array(ingredient_array)
        recipe_list.each{|item| puts item}
    end 
end