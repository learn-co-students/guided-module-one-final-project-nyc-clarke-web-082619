class Recipe < ActiveRecord::Base
    has_many :ingredients_recipes
    has_many :ingredients, through: :ingredients_recipes

    def display_recipe_info

        puts "\n ------ #{self.name} -------\n"
        puts ''
        puts "Ingredients:"
        self.ingredients.each{|ing| puts " - " + ing.name}
        puts ''
        puts "Instructions: \n - #{self.content}"

    end


    def self.prioritize_recipes_from_ingredient_array(ingredient_array)
        recipe_array_with_duplicates = ingredient_array.map{|ingredient| ingredient.recipes}.flatten
    end

    def self.inclusive_recipes_from_ingredient_array(ingredient_array)
        ingredient_array.map{|item| item.recipes}.flatten.uniq
    end

    def self.inclusive_names_from_ingredient_array(ingredient_array)
     #  ingredient_array.map {|item| item.recipes.map{|rec| rec.name}}.flatten.uniq
        inclusive_recipes_from_ingredient_array(ingredient_array).map{|rec| rec.name}.flatten.uniq
    end

    def self.print_inclusive_list_from_ingredient_array(ingredient_array)
        recipe_list = inclusive_names_from_ingredient_array(ingredient_array)
        recipe_list.each{|item| puts item}
    end 
end