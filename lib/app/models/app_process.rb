def greeting
  puts "Welcome to The Real-Time, In a Bind, Online, Pickup Line Hotline!"
end

def create_user
  input = prompt.select("Asuuuh?", %w(Create\ Profile Exit))
    if input == 'Create Profile'
      name = prompt.ask("What is your name?", required: true){|q| q.modify :capitalize}
      phone = prompt.ask("What is your Phone Number", required: true)
      User.create(name: name, phone_number: phone)
    else
      exit_program
    end
end

def look_at_options
  options = ['Get a line', 'See what worked', "Lives you've ruined"]
  input = prompt.select("So What's good?", options)
    if input == options[0]
      select_provider
    elsif input == options[1]
      all_that_worked
    else
      @@fired_providers.each do |prov|
        puts "#{prov} is now living back at their mom's spot."
      end
    end
end

def select_provider
  provider_selection = prompt.select("Which one of these assholes you want helping you?", %w(Chad Tanner Braxton Brenadeigh Kavaleigh DeAnnalynn Exit))
  exit_program if provider_selection == 'Exit'
  self.update(provider_id: Provider.find_by(name: self).id)
end

def set_location
  location_selection = prompt.select("Choose your location", ['Hogwarts', 'Mos Eisley Cantina', 'The Gym', 'A Coffee Shop', 'The Dog Park', 'The Beach or Pool', 'A Programming Meetup', 'Democratic National Convention', 'A Bar', 'Another Location', 'Exit'])
  exit_program if provider_selection == 'Exit'
  self.update(location_id: Location.find_by(name: location_selection).id)
end

def pickup_lines_for_location
  users_location_lines = PickupLine.all.select{|line| line.location.name == self.location}
end

def random_line
  pickup_lines_for_location.sample.content
end

def interaction_with_provider
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
                      self.accepted_lines <<sample
                    end
                else  
                  puts 'TAAAAIGHT!'
                   self.accepted_lines <<sample
                end
        else  
           puts 'TAAAAIGHT!'
            self.accepted_lines <<sample
        end
end

@@fired_providers = []

def fire_provider?
  input = prompt.select("We have noticed you have rejected 3 of our Pickup Lines, should we fire your provider?" , %w(Yes No))
      if input == 'Yes'
        @@fired_providers << self.provider.name
        fired = Provider.find_by(name: self.provider)
        fired.delete
        prompt.multiline("Write your complaint here:")
        prompt.keypress("Reading complaint....", timeout:4)
        prompt.keypress("You're right, they sucked, firing your provider now....", timeout:3)
        prompt.keypress("They took it pretty okay, said they're gonna go finish school or something!", timeout:2)
      else
        return false
      end
end

def disable_provider
  arr1 = Provider.all.map{|prov| prov.name}
  hash = {}
  @@fired_providers.each do |prov|
        hash[:name] = prov 
        hash[:disabled] = "(fired)"
  end
  arr1 << hash 
  prompt.select('Pick a new provider', arr1)
end

def self.all_that_worked
  lines = User.all.map{|user| user.accepted_lines}
  lines.each do |line|
    puts "here's what has worked so far:"
    puts line
  end
end

def retry?
  response = prompt.select("Would you like to try again?", %w(Choose\ another\ provider  Exit))
  if response == 'Choose another provider'
    disable_provider
  elsif response == 'Exit'
    exit_program
  else
    cancel_membership
  end
end

def cancel_membership
    user = User.all.find_by(name: self)
    user.delete
    puts "You're just gonna walk away, you sketchball? Fine have fun going home alone."
end

def exit_program
  puts 'Go get some, dawg.'
end

