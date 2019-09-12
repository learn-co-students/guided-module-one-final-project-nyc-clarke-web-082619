require_relative '../config/environment'
require 'pry'
require "tty-prompt"

system 'clear'

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

cli = CommandLineInterface.new

cli.greet
cli.main_menu


# user_input = prompt.ask('Which ingredients do you NEED to use? (comma sep list)') do |q|
#     q.convert -> (input) { input.split(/,\s*/) }
# end 
# user_input = cli.ask_for_required_ingredients
# choices = cli.inclusive_recipe_search(user_input)




# binding.pry

