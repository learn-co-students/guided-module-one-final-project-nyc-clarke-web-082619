#require_relative 'config/environment'
require 'pry'
require_relative './lib/pickup_line_seed_data'
require "tty-prompt"


prompt = TTY::Prompt.new



puts "Welcome to The Real-Time, In a Bind, Online, Pickup Line Hotline!"

prompt.select("", %w(Create\ Profile Exit))

prompt.ask("What is your name?", required: true) do |q|
    q.required true
    q.validate /\A\w+\Z/
    q.modify   :capitalize
  end

  prompt.ask("What is your Phone Number", required: true) do |q|
    q.required true
    q.validate /\A\w+\Z/
    q.modify   :capitalize

  end
  

prompt.select("Choose your location" , %w(Bar Gym DogPark Church))



prompt.select("We have noticed you have rejected a number of our PickUp Lines, Would you like to make a complaint?" , %w(Yes No))
prompt.multiline("Write your complaint here:")
prompt.keypress("Reading complaint....", timeout:4)
prompt.keypress("Firing your Provider....", timeout:3)

puts prompt.select("Your Provider has been fired. Would you like to try again?" , %w(Choose\ another\ location  Exit))





chad = User.new(name: 'Chad', phone_number: '323-432-1266')
hogwarts = Location.new(name: 'Hogwarts')
mos_eisley_cantina = Location.new(name: 'Mos Eisley Cantina')
gym = Location.new(name: 'The Gym')
coffee_shop = Location.new(name: 'A Coffee Shop')
dog_park = Location.new(name: 'The Dog Park')
beach_pool = Location.new(name: 'The Beach or Pool')
programming_meetup = Location.new(name: 'A Programming Meetup')
dem_national_convention = Location.new(name: 'Democratic National Convention')
bar = Location.new(name: 'A Bar')
other_location = Location.new(name: 'Another Location')
other_location.save


$is_your_daddy.each do |line|
  new_line = PickupLine.new(content: line, location_id: other_location.id)
  new_line.save
end

binding.pry


puts 'k'
