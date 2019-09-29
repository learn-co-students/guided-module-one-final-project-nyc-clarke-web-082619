class Ingredient < ActiveRecord::Base
    has_many :ingredients_recipes
    has_many :recipes, through: :ingredients_recipes
    has_many :profiles_ingredients
    has_many :profiles, through: :profiles_ingredients

    def recipe_names
        recipes.map{|rec| rec.name}
    end

    

    # def self.find_single_ingredient_by_name(ingredient_name)
    #     self.all.find_by(name: ingredient_name)
    # end

    # def self.find_ingredients_by_name(ingredient_name_array)
    #     new_array = []
    #     ingredient_name_array.each do |ingredient_name|
    #         new_array << self.find_single_ingredient_by_name(ingredient_name)
    #     end
    #     new_array
    # end

    # ------------------new stuff ------------

    def find_recipes_that_use_me_and_create_link
        my_recipes = Recipe.search_recipe_ingredient_lists_for_ingredient(self)
        my_recipes.each {|recipe| self.recipes << recipe}
    end

end




#---------------- ORIGINAL CODE ------------------

# has_many :ingredients_recipes
#     has_many :recipes, through: :ingredients_recipes

#     def recipe_names
#         recipes.map{|rec| rec.name}
#     end

#     def self.find_single_ingredient_by_name(ingredient_name)
#         self.all.find_by(name: ingredient_name)
#     end

#     def self.find_ingredients_by_name(ingredient_name_array)
#         new_array = []
#         ingredient_name_array.each do |ingredient_name|
#             new_array << self.find_single_ingredient_by_name(ingredient_name)
#         end
#         new_array
#     end