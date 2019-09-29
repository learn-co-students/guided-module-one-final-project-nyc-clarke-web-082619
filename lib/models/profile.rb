class Profile < ActiveRecord::Base 
    has_many :profiles_ingredients
    has_many :profiles_recipes
    has_many :recipes, through: :profiles_recipes
    has_many :ingredients, through: :profiles_ingredients

    def self.check_profile_name_availability(username)
        if Profile.all.find_by(name: username)
            return false
        else
            return true
        end
    end

    def self.create_profile_with_name(username)
        self.create(name: username)
    end

    def self.create_profile_with_name_if_available(username)
        username.downcase!
        if self.check_profile_name_availability(username)
            self.create_profile_with_name(username)
        else
            return false
        end
    end

    def welcome_user
        puts "Welcome #{self.name}!"
    end

    def add_ingredient(ingredient)
        if !self.ingredients.include?(ingredient) 
            self.ingredients << ingredient
        end
    end

    def add_recipe(recipe)
        self.recipes << recipe
    end

    def ingredient_names
        self.ingredients.map {|ingredient| ingredient.name}
    end

    def remove_ingredient(ingredient)
        self.ingredients.delete(ingredient)
    end
end 