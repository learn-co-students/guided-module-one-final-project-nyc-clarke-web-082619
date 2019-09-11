require_relative '../config/environment'
require 'pry'


require 'tty-prompt'

ActiveRecord::Base.logger.level = 1 
prompt = TTY::Prompt.new



puts "Welcome to The Real-Time, In a Bind, Online, Pickup Line Hotline!"

prompt.select("", %w(Create\ Profile Exit))

name = prompt.ask("What is your name?", required: true) do |q|
    q.modify   :capitalize
  end

  phone = prompt.ask("What is your Phone Number", required: true) do |q|
  end
  
    current_user = User.create(name: name, phone_number: phone)

  provider_selection = prompt.select("Which one of these assholes you want helping you?", %w(Chad Tanner Braxton Brenadeigh Kavaleigh DeAnnalynn))

  current_user.update(provider_id: Provider.find_by(name: provider_selection).id)

location_selection = prompt.select("Choose your location", ['Hogwarts', 'Mos Eisley Cantina', 'The Gym', 'A Coffee Shop', 'The Dog Park', 'The Beach or Pool', 'A Programming Meetup', 'Democratic National Convention', 'A Bar', 'Another Location'])

  current_user.update(location_id: Location.find_by(name: location_selection).id)
  users_location_lines = PickupLine.all.select{|line| line.location.name == location_selection}
  sample = users_location_lines.sample.content 

  prompt.keypress('Cool, chill for a sec while we find something solid...', timeout:3)
  puts ''
  prompt.keypress("Alright, so based on your location, here's a pretty solid line:", timeout:1)
  prompt.keypress('', timeout:1)
  puts '===================='
  puts sample
  puts '===================='
  puts ''
  answer1 = prompt.select('Did they buy it?', %w(fershur nawww))
       if answer1 == 'nawww'
        puts ''
          prompt.keypress('my b on that, try this:', timeout: 1)
          puts ''
        puts '===================='
          sample = users_location_lines.sample.content 
          puts sample
          puts '===================='
          puts ''
          answer2 = prompt.select('did they buy it?', %w(fershur nawww))
                if answer2 == 'nawww'
                  puts ''
                   prompt.keypress('Ok, this will deff work', timeout:1)
                   puts ''
                   puts '===================='
                   sample = users_location_lines.sample.content 
                   puts sample
                   puts '===================='
                   puts ''
                   answer3 = prompt.select("If this doesn't work this person is whack.", %w(fershur nawww))
                      puts '' 
                   if answer3 == 'nawww'
                      puts ''
                     prompt.keypress("Wooooooow, it's like that?", timeout: 1)
                    else
                     puts 'TAAAAIGHT!'
                    end
                else  
                  puts 'TAAAAIGHT!'
                end
        else  
           puts 'TAAAAIGHT!'
        end


# if rejected, OR success line of logic
prompt.select("We have noticed you have rejected 3 of our Pickup Lines, should we fire your provider?" , %w(Yes No))
prompt.multiline("Write your complaint here:")
prompt.keypress("Reading complaint....", timeout:4)
prompt.keypress("Firing your Provider....", timeout:3)

puts prompt.select("Your Provider has been fired. Would you like to try again?" , %w(Choose\ another\ location  Exit))



binding.pry


puts 'k'
