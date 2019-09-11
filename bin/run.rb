require_relative '../config/environment'
require 'pry'


require 'tty-prompt'

ActiveRecord::Base.logger.level = 1 
@prompt = TTY::Prompt.new

greeting
create_user #add option to log-in w/ passcode
look_at_options
select_provider
set_location
pickup_lines_for_location
random_line
#first_pass
#accept_or_pass?
#second_pass
#accept_or_pass?
#final_pass
fire_provider
disable_provider
retry?









# def run
# greeting
# create_user
# select_provider
# set_location
# pickup_lines_for_location
# random_line
# interaction_with_provider
# end

  



#  if rejected, OR success line of logic


# puts prompt.select("Your Provider has been fired. Would you like to try again?" , %w(Choose\ another\ location  Exit))



# binding.pry


# puts 'k'
