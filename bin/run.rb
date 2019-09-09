require_relative '../config/environment'
require 'pry'
require "tty-prompt"

system 'clear'

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

prompt = TTY::Prompt.new


new_cli = CommandLineInterface.new
new_cli.greet
# user_input = new_cli.gets_user_input


user_input = prompt.ask('Which ingredients do you NEED to use? (comma sep list)') do |q|
    q.convert -> (input) { input.split(/,\s*/) }
end 

user_input = user_input.map{|item| item.capitalize}
foods = Ingredient.find_foods(user_input)

Recipe.print_list_from_ingredient_array(foods)

binding.pry

