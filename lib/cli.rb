class CommandLineInterface
    UI = TTY::Prompt.new


    def main_menu
        puts `clear`
        UI.select("What would you like to do?") do |menu|
            menu.choice 'Search Recipes by Ingredients', -> do
                # ask user for ingredients separated by commas
                user_input   = ask_for_required_ingredients
                # find recipes that match
                recipe_names = prioritized_recipe_search(user_input)
                # users pick from those recipes, then show detail
                choose_recipes(recipe_names)
                UI.keypress("Press Enter to go back")
                main_menu
            end
            menu.choice 'Exit'
          end
    end

    def choose_recipes(recipe_instances)
        chosen_recipe = UI.select("Select a recipe:") do |menu|
            recipe_instances.each do |recipe|
                menu.choice recipe.name, -> { recipe.display_recipe_info }
            end
        end
        # display_recipe_details(chosen_recipe)
    end

    def ask_for_required_ingredients
        user_input = UI.ask('Which ingredients do you NEED to use? (comma sep list)') do |q|
            q.convert -> (input) { input.split(/,\s*/) }
        end
    end

    def greet
        puts 'Welcome to the Mixer, the app that helps you clean out your pantry!'
    end

    def inclusive_recipe_search(user_input)
        user_input = user_input.map { |item| item.capitalize }
        ingredient_array = Ingredient.find_ingredients_by_name(user_input)
        Recipe.inclusive_recipes_from_ingredient_array(ingredient_array)
    end

    def prioritized_recipe_search(user_input)
        user_input = user_input.map { |item| item.capitalize }
        ingredient_array = Ingredient.find_ingredients_by_name(user_input)
        Recipe.prioritize_recipes_from_ingredient_array(ingredient_array)
    end

    def display_recipe_details(rec)
        chosen_recipe_data = Recipe.find_by(name: rec)
        chosen_recipe_data.display_recipe_info
    end
end 