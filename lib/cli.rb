class CommandLineInterface
    UI = TTY::Prompt.new


    def main_menu
        puts `clear`
        greet
        UI.select("What would you like to do?") do |menu|
            menu.choice 'Log In', -> do 
                sign_in_to_profile
                main_menu
            end
            menu.choice 'Create New Profile', -> do 
                create_profile_menu
            end
            menu.choice 'Search Recipes by Ingredients', -> do 
                search_recipes_by_ingredients_menu
            end
            menu.choice 'Exit', -> do
                puts " \nGoodbye!"
            end
        end
    end

    def go_to_profile_page(profile)
        UI.select("What would you like to do?") do |menu|
            menu.choice 'See my saved ingredients', -> do
                puts `clear`
                display_ingredient_names(profile.ingredient_names)
                # new method here
                go_to_profile_page(profile)
            end
            menu.choice 'Find recipes with my saved ingredients', -> do
                puts `clear`
                if profile.ingredient_names.length > 0
                    find_recipes_for_profile_ingredients(profile, profile.ingredient_names)
                else
                    puts "You have no ingredients saved."
                end
                # new method here
                go_to_profile_page(profile)
            end
            menu.choice 'Add an ingredient to my list', -> do
                ask_for_ingredient_and_add(profile)
                go_to_profile_page(profile)
            end
            menu.choice 'Remove an ingredient from my list', -> do
                puts `clear`
                display_ingredient_names(profile.ingredient_names)
                ask_for_ingredient_and_remove(profile)
                puts `clear`
                display_ingredient_names(profile.ingredient_names)
                go_to_profile_page(profile)
            end
            menu.choice 'Return to Main Menu', -> do
                return
            end
        end
    end

    def find_recipes_for_profile_ingredients(profile, ingredient_names)
        user_input = UI.multi_select("Select ingredients to search (space to select, enter to finish)", ingredient_names)
        # find recipes that match

        recipe_instances = prioritized_recipe_search(user_input)
         
        # # users pick from those recipes, then show detail
         if recipe_instances.length == 0 
             puts "Sorry, no recipes found for any of those ingredients."
        else
             choose_recipes(recipe_instances, user_input)
        end
    end

    def display_ingredient_names(ingredient_names)
        puts 'My ingredients:'
        ingredient_names.each {|name| puts "       - #{name}"}
        puts ''
    end

    def ask_for_ingredient_and_add(profile)
        ingredient_name = UI.ask('Enter the name of the ingredient you would like to add (Enter "q" to go back to profile menu):') do |q|
            q.required true
            q.modify :down, :trim
        end

        if ingredient_name == 'q'
            return
        elsif Ingredient.find_by(name: ingredient_name)
            new_ingredient = Ingredient.find_by(name: ingredient_name)
            profile.add_ingredient(new_ingredient)
        else 
            new_ingredient = Ingredient.create(name: ingredient_name)
            new_ingredient.find_recipes_that_use_me_and_create_link
            profile.add_ingredient(new_ingredient)
        end
    end
 
    def ask_for_ingredient_and_remove(profile)
        ingredient_name = UI.ask('Enter the name of the ingredient you would like to remove (Enter "q" to go back to profile menu):') do |q|
            q.required true
            q.modify :down, :trim
        end

        if ingredient_name == 'q'
            return
        elsif Ingredient.find_by(name: ingredient_name)
            new_ingredient = Ingredient.find_by(name: ingredient_name)
            profile.remove_ingredient(new_ingredient)
            puts "Removed #{ingredient_name}"
        else 
            puts "You don't have any #{ingredient_name} in your list."
            return
        end
    end

    def sign_in_to_profile
        name_input = UI.ask('Enter your profile name: (Enter "q" to go back):') do |q|
            q.required true
            q.modify :down, :trim
        end

        if name_input == 'q'
            return
        else
            user_profile = Profile.find_by(name: name_input)
            if user_profile.class == Profile
                user_profile.welcome_user
                go_to_profile_page(user_profile)
               #UI.keypress("Press Enter to go back", keys: [:return])
                return
            else
                puts "Sorry, that profile was not found."
                UI.keypress("Press Enter to go back", keys: [:return])
                return
            end
        end


    end

    def create_profile_menu
        name_input = UI.ask('What would you like your profile name to be? (Enter "q" to go back):') do |q|
            q.required true
            q.modify :down, :trim
        end

        if name_input == 'q'
            main_menu
        else
            UI.select("Is #{name_input} correct?") do |yes_no_menu|
                yes_no_menu.choice 'Yes', -> do 
                    if Profile.create_profile_with_name_if_available(name_input)
                        puts "Profile successfully created!"
                        UI.keypress("Press Enter to go back", keys: [:return])
                        main_menu
                    else
                        puts "Sorry, that profile name is not available."
                        UI.keypress("Press Enter to go back to the main menu", keys: [:return])
                        main_menu
                    end
                end
                yes_no_menu.choice 'No', -> do
                    UI.keypress("Press Enter to go back to the main menu", keys: [:return])

                    main_menu
                end
            end
        end
    end

    def search_recipes_by_ingredients_menu
        # ask user for ingredients separated by commas
        user_input  = ask_for_required_ingredients

        if !user_input 
            puts "Please enter at least one ingredient."
        else 
            # find recipes that match
            recipe_instances = prioritized_recipe_search(user_input)
            # users pick from those recipes, then show detail
            if recipe_instances.length == 0 
                puts "Sorry, no recipes found for any of those ingredients."
            else
                choose_recipes(recipe_instances, user_input)
            end
        end
        UI.keypress("Press Enter to go back", keys: [:return])
        puts `clear`
        main_menu
    end

    def choose_recipes(recipe_instances, ingredient_name_array) 
        chosen_recipe = UI.select("Select a recipe:") do |menu|
            recipe_instances.each do |recipe|
                menu.choice recipe.preview(ingredient_name_array), -> { recipe.display_recipe_info }
            end
        end
    end

    def ask_for_required_ingredients
        user_input = UI.ask('Which ingredients do you NEED to use? (comma sep list)') do |q|
            q.convert -> (input) { input.split(/,\s*/) }
        end
    end

    def greet
        puts '----------------------Welcome to the PantrySweeper!----------------------------'
        puts 'The app that helps you clean out your pantry using recipes from Epicurious.com!'
        puts '                         *   *   *   *   *  *'
        puts ''
    end

    def inclusive_recipe_search(user_input)
        user_input = user_input.map { |item| item.capitalize }
        ingredient_array = Ingredient.find_ingredients_by_name(user_input)
        Recipe.inclusive_recipes_from_ingredient_array(ingredient_array)
    end

    def prioritized_recipe_search(user_input)
        user_input = user_input.map { |item| item.downcase }
        ingredient_array = user_input.map do |item|
            if Ingredient.find_by(name: item)
                Ingredient.find_by(name: item)
            else 
                new_ingredient = Ingredient.create(name: item)
                new_ingredient.find_recipes_that_use_me_and_create_link
                new_ingredient
            end 
        end
        Recipe.prioritize_recipes_from_ingredient_array(ingredient_array)
    end

    def display_recipe_details(rec)
        puts `clear`
        chosen_recipe_data = Recipe.find_by(name: rec)
        chosen_recipe_data.display_recipe_info

    end
end 