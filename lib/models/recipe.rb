class Recipe < ActiveRecord::Base
    has_many :ingredients_recipes
    has_many :ingredients, through: :ingredients_recipes
    has_many :profiles_recipes
    has_many :profiles, through: :profiles_recipes

    def display_recipe_info

        puts "\n ------ #{self.name} -------\n"
        puts ''
        puts "Ingredients:"
        eval(self.ingredient_list).each{|ing| puts " - " + ing}
        puts ''
        puts "Instructions:"
        eval(self.content).each{|section| puts " - " + section}

    end

    def preview(ingredient_name_array)
        #Returns a string
        preview_block = ""
        preview_block += self.name



        preview_block
    end 

    # Template of goal 
    # weekend fry-up
    #     1 or 2 eggs
    #     1-2 slices of bacon
    #     Salt + fresh pepper
    #     ... and 6 more ingredients 


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
        ingredient_name = ingredient.name.downcase
        Recipe.all.select do |recipe|
            has_ingredient = false
            eval(recipe.ingredient_list).each do |entry| 
               if entry.downcase.include?(ingredient_name)
                has_ingredient = true
               end
            end
            has_ingredient
        end
    end

    def self.print_names_of_recipes_that_include_ingredient(ingredient)
        search_recipe_ingredient_lists_for_ingredient(ingredient).each {|recipe| puts recipe.name}
    end



end