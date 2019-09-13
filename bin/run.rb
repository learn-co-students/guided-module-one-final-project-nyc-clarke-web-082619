require_relative '../config/environment'
require 'pry'
require 'tty-prompt'

ActiveRecord::Base.logger.level = 1 
$prompt = TTY::Prompt.new

system 'clear'

#run 

run_twilio(twilio_markov_generator)

puts 'pray this works'
