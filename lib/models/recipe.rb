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
        recipe_hash_with_count = Hash.new(0)
        recipe_array_with_duplicates.each do |recipe|
            recipe_hash_with_count[recipe] += 1
        end
        # recipe_hash_with_count.each do |k, v|
        #     puts "#{k.name} appears #{v} times"
        # end
        sorted_recipes_by_count = recipe_hash_with_count.sort_by{|recipe, count| count}
        sorted_recipes_by_count.reverse!.flatten!
        sorted_recipes_by_count = sorted_recipes_by_count.select{|element| element.class == Recipe}
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

    #---------------- NEW STUFF WITH SCRAPED DATA ------------

    def self.search_recipe_ingredient_lists_for_ingredient(ingredient)
        #Takes ingredient, returns array of recipes that have that ingredient
        Recipe.all.select do |recipe|
            has_ingredient = false
            eval(recipe.ingredient_list).each do |entry| 
               if entry.include?(ingredient)
                has_ingredient = true
               end
            end
            has_ingredient
        end
    end



end