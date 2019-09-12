require_relative '../config/environment'
require 'pry'


require 'tty-prompt'

ActiveRecord::Base.logger.level = 1 
$prompt = TTY::Prompt.new

system 'clear'
Provider.last.destroy
def run
  greeting
  log_in_screen
  set_location  
  pickup_lines_for_location
  random_line
  begin_generation
  flow
end

run 

puts 'pray this works'
