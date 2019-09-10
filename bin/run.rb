require_relative '../config/environment'
require 'pry'


require 'tty-prompt'

ActiveRecord::Base.logger.level = 1 
prompt = TTY::Prompt.new



def run
greeting
create_user
select_provider
set_location
pickup_lines_for_location
random_line
interaction_with_provider
end

  



# if rejected, OR success line of logic


puts prompt.select("Your Provider has been fired. Would you like to try again?" , %w(Choose\ another\ location  Exit))



binding.pry


puts 'k'
