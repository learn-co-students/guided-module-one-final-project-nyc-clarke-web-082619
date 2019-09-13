require_relative '../config/environment'
require 'pry'
require 'tty-prompt'

ActiveRecord::Base.logger.level = 1 
$prompt = TTY::Prompt.new

system 'clear'

def run
  intro
  greeting
  log_in_screen
  set_location  
  pickup_lines_for_location
  random_line
  begin_generation
  flow
end

run 

#twilio_text(mini_markov_process)

puts 'pray this works'
