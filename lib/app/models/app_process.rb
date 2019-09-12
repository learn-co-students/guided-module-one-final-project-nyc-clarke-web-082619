
require 'pry'
  def greeting
    #add a photo, sound etc
    puts "Welcome to The Real-Time, In a Bind, Online, Pickup Line Hotline!"
  end

  #def play_song
    #%x(afplay /Users/PuffingtonFiles/Desktop/butterfly.wav)
  #end

  #def say_line
    #%x(say 'hell fucking yes')
  #end

  #def show_pic 
#   require 'catpix'
# Catpix::print_image "/Users/PuffingtonFiles/Desktop/pickupline.jpg",
#   :limit_x => 1.0,
#   :limit_y => 0,
#   :center_x => true,
#   :center_y => true,
#   :bg => "white",
#   :bg_fill => true,
#   :resolution => "low"
#end

#def markov_chains
#require 'markov_chains'
#text = File.read("/Users/PuffingtonFiles/Desktop/pickup_lines.txt")
#generator = MarkovChains::Generator.new(text)
#generator.get_sentences(5)
#generate 5-10, store in an array and select the three longest
#then use them in place of the three random ones
#end

  def log_in_screen
    input = $prompt.select("Asuuuh?", %w(Create\ Profile Login Exit))
      if input == 'Create Profile'
        create_profile
        look_at_options
      elsif input == 'Login'
        log_in_to_account
      else
        exit_program
      end
  end

  def create_profile
    name = $prompt.ask("What is your name?", required: true){|q| q.modify :capitalize}
    phone = $prompt.ask("What is your Phone Number", required: true)
    @current_user = User.create(name: name, phone_number: phone, active_user: true)
  end

  def log_in_to_account
    heart = $prompt.decorate(' 😘 ') 
    login_name = $prompt.select("Welcome back, who are you?", User.pluck(:name), "Exit")
    @current_user = User.find_by(name: login_name)
    $prompt.mask("Sup #{login_name}? What's your password?", mask: heart)
    look_at_options
  end

  def look_at_options
    options = ['Get a line', 'See what worked', "Lives you've ruined"]
    input = $prompt.select("So What's good?", options)
      if input == options[0]
        provider_list
      elsif input == options[1]
        all_that_worked
        look_at_options
      else
        ruined_lives
      end
  end

  def ruined_lives
    fired_ppl = Provider.where(employed: false).map(&:name)
      if fired_ppl.empty?
        $prompt.error("You could be the first person to wreck someone's life") 
        look_at_options
      else 
        fired_ppl.each{|name| $prompt.keypress("#{name} is now living back at mom's spot.", timeout:3)}
        look_at_options
      end
  end

  def set_location
    @location_selection = $prompt.select("Choose your location", ['Hogwarts', 'Mos Eisley Cantina', 'The Gym', 'A Coffee Shop', 'The Dog Park', 'The Beach or Pool', 'A Programming Meetup', 'Democratic National Convention', 'A Bar', 'Another Location', 'Exit'])
    exit_program if @provider_selection == 'Exit'
    @current_user.update(location_id: Location.find_by(name: @location_selection).id)  
  end
  
  def pickup_lines_for_location
    @users_location_lines = PickupLine.all.select{|line| line.location_id == @current_user.location_id} 
  end
  
  def random_line
    @users_location_lines.sample.content  
  end
  
  def begin_generation
    $prompt.keypress('Cool, chill for a sec while we find something solid...', timeout:3)
    puts ''
  end

  def attempt_line(msg) 
    puts ''
    $prompt.keypress( msg, timeout:1)
    puts ''
    puts '===================='
    puts random_line
    puts '===================='
    puts ''
  end

  def accept_or_pass?(msg) 
    answer = $prompt.select(msg, %w(deff nawww))
      if answer == 'nawww'
        return false
      else
        puts 'TAAAAIGHT!'
        @current_user.update(accepted_lines: random_line)
        exit_program  
      end 
  end

  def fire_provider? 
    input = $prompt.select("We have noticed you have rejected 3 of our Pickup Lines, should we fire your provider?" , %w(Yes No))
      if input == 'Yes'
        fired = Provider.find_by(id: @current_user.provider_id)
        fired.update(employed: false)
        complaint
      else
        puts 'very chill of you'
      end
  end

  def complaint
    $prompt.multiline("Write your complaint here:")
    $prompt.keypress("Reading complaint....", timeout:2)
    $prompt.keypress("You're right, they sucked, firing your provider now....", timeout:1)
    $prompt.keypress("They took it pretty okay, said they're gonna go finish school or something!", timeout:1)
  end

  def provider_list
    $all_employees = Provider.where(employed:true).map(&:name)
    Provider.where(employed: false).map(&:name).each{|name| $all_employees << {name: name, disabled: "(fired)"}}
    select_provider_and_update_user
  end
  
  def select_provider_and_update_user
    @provider_selection = $prompt.select("Which one of these assholes you want helping you?", $all_employees, "Exit")  #remove?
    exit_program if @provider_selection == 'Exit'
    @current_user.update(provider_id: Provider.find_by(name: @provider_selection).id)
  end

  def retry?
    response = $prompt.select("Would you like to try again?", %w(Choose\ another\ provider Exit Cancel\ Membership))
      if response == 'Choose another provider'     
        provider_list
        flow
      elsif response == 'Exit'
        exit_program
      else
        cancel_membership
      end
  end


  $attempt_line_msg1 =  "Alright, so based on your location, here's a pretty solid line:"
  $attempt_line_msg2 = 'my b on that, try this:'
  $attempt_line_msg3 = 'Ok, this will deff work'
  $accept_pass1 = 'Did they buy it?'
  $accept_pass2 = "You guys must be on your way to your place by now, right?"
  $accept_pass3 = "If this doesn't work that person is whack."

  def flow
    attempt_line($attempt_line_msg1)
      if accept_or_pass?($accept_pass1) == false
        attempt_line($attempt_line_msg2)
          if accept_or_pass?($accept_pass2) == false
            attempt_line($attempt_line_msg3)
              if accept_or_pass?($accept_pass3) == false 
                fire_provider?
                try_again?
              else
                try_again?
              end
          else
            try_again?  
          end
      else
        exit_program
      end    
  end

  def try_again?
    retry?
    random_line
    begin_generation
    flow   
  end

  def all_that_worked
    lines = User.all.map{|user| user.accepted_lines}.compact
      if lines.empty?
        $prompt.error('You can be the first person to get one if you got enough game')
        $prompt.keypress('', timeout:2)
      else 
        puts "here's what has worked so far:"
        puts '============================='
        lines.each{|line| puts " 🍆  #{line}"} 
      end
  end
  
  def cancel_membership
    user = User.all.find_by(name: @current_user.name)
    user.update(active_user: false)
    puts "You're just gonna walk away, you sketchball? Fine have fun going home alone."
    exit_program
  end
  
  def exit_program
    puts 'Go get some, dawg.'
    exit!
  end


  puts 'pleh'

