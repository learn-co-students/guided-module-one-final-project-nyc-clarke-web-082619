
require 'pry'

def intro
   t1 = Thread.new do 
     show_pic
   end
   play_song("/Users/PuffingtonFiles/Desktop/butterfly.wav")
end

  def greeting
    puts "Welcome to The Real-Time, In a Bind, Online, Pickup Line Hotline!"
  end

  def play_song(file)
    %x(afplay "#{file}")
  end

  def say_line(msg)
    %x(say "#{msg}")
  end

   def show_pic 
   Catpix::print_image "/Users/PuffingtonFiles/Desktop/pickupline.jpg",
   :limit_x => 1.0,
   :limit_y => 0,
   :center_x => true,
   :center_y => true,
   :bg => "white",
   :bg_fill => true,
   :resolution => "low"
  end

  def log_in_screen
    puts ""
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

  def log_in_to_account
    heart = $prompt.decorate(' 😘 ') 
    login_name = $prompt.select("Welcome back, who are you?", User.pluck(:name), "Exit")
    @current_user = User.find_by(name: login_name)
    $prompt.mask("Sup #{login_name}? What's your password?", mask: heart)
    look_at_options
  end

  def look_at_options
    options = ['Get a new Pickup line', 'See what lines already worked', "See who we've fired"]
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

  def set_location
    @location_selection = $prompt.select("Choose your location", ['Hogwarts', 'Mos Eisley Cantina', 'The Gym', 'A Coffee Shop', 'The Dog Park', 'The Beach or Pool', 'A Programming Meetup', 'Democratic National Convention', 'A Bar', 'Another Location', 'Exit'])
    exit_program if @provider_selection == 'Exit'
    @current_user.update(location_id: Location.find_by(name: @location_selection).id)  
  end
  
  #provider methods

  def provider_list
    $all_employees = Provider.where(employed:true).map(&:name)
    $fired_employees = Provider.where(employed: false)
    $fired_employees.map(&:name).each{|name| $all_employees << {name: name, disabled: "(fired)"}}
    if $fired_employees.length == Provider.all.length
      sleaze_bot_9000_engage
    else
    select_provider_and_update_user
    end
  end

  def select_provider_and_update_user
    @provider_selection = $prompt.select("Which one of these a-holes you want helping you?", $all_employees, "Exit") 
    exit_program if @provider_selection == 'Exit'
    @current_user.update(provider_id: Provider.find_by(name: @provider_selection).id)
  end

  #bot methods
  def markov_process
    text = File.read("/Users/PuffingtonFiles/Desktop/total_data.txt")
    generator = MarkovChains::Generator.new(text)
    arr = generator.get_sentences(8)
    chosen = arr.sort_by{|sent| sent.length}[-3..-1]
    puts chosen[0]
    puts "=========="
    puts chosen[1]
    puts "=========="
    puts chosen[2]
    puts "=========="
  end

    def mini_markov_process
    text = File.read("/Users/PuffingtonFiles/Desktop/total_data.txt")
    generator = MarkovChains::Generator.new(text)
    arr = generator.get_sentences(8)
    chosen = arr.sort_by{|sent| sent.length}[-3..-1]
    chosen[0]
    end

  def sleaze_bot_9000_engage 
      $prompt.keypress('Sadly, the whole team got fired...', timeout: 2)
      $prompt.keypress('This means we have to go for the nuclear option', timeout: 1)
      say_line('Get ready for Sleaze Bot 9000')
      $prompt.keypress('Get ready for SleazeBot9000!!!!', timeout: 1)
      init_bot
      set_bot_location
  end

  def init_bot
    say_line('Choose your destiny')
    @provider_selection = $prompt.select("THERE IS NOW ONLY ONE WHO CAN HELP YOU", 'SleazeBot90000', "Exit") 
        if @provider_selection == 'Exit'
          say_line('There is no escape')
          $prompt.error('There is no escape')
          init_bot 
        else 
          Provider.create(name: 'SleazeBot9000', employed: true)
          @current_user.update(provider_id: Provider.find_by(name: 'SleazeBot9000').id)
        end
  end

  def set_bot_location
    say_line('Your brain is small and I will make all of your decisions')
    @location_selection = $prompt.select("Choose your location", ['Sleazebot', 'Will', 'Choose', 'What', 'Is', 'Best', 'For', 'You'])
    @current_user.update(location_id: Location.new(name: 'Bot Heaven'))
    bot_flow
  end

  def bot_flow
    $prompt.keypress('Use these words to receive attention from your targeted mate', timeout: 2)
    puts ''
    puts '=========='
    markov_process
    puts ''
    say_line('are you doing the no pants dance?')
    bot_prompt = $prompt.select('Have you successfully mated?', %w(Yes No Exit))
    puts ''
      if bot_prompt == 'Yes'
        say_line('giggity')
        exit_program
      else 
        bot_accept
      end
  end

  def bot_accept
    say_line('I am in control')
    $prompt.error("You can't give up now! Here are more options!")
    bot_flow
  end

  #pickup_line generation methods

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
    $prompt.keypress("Reading complaint....", timeout:3)
    $prompt.keypress("You're right, they sucked, firing your provider now....", timeout:2)
    $prompt.keypress("They took it pretty okay, said they're gonna go finish school or something!", timeout:2)
  end
  
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

  def try_again?
    retry?
    random_line
    begin_generation
    flow   
  end

  #methods never directly called/variables

  $attempt_line_msg1 =  "Alright, so based on your location, here's a pretty solid line:"
  $attempt_line_msg2 = 'my b on that, try this:'
  $attempt_line_msg3 = 'Ok, this will deff work, if not that person is whack'
  $accept_pass1 = 'Did they buy it?'
  $accept_pass2 = "You guys must be on your way to your place by now, right?"
  $accept_pass3 = "Please tell me that worked, I don't wanna get fired."

  
  def create_profile
    name = $prompt.ask("What is your name?", required: true){|q| q.modify :capitalize}
    phone = $prompt.ask("What is your Phone Number", required: true)
    @current_user = User.create(name: name, phone_number: phone, active_user: true)
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
    play_song("/Users/PuffingtonFiles/Desktop/bye_bye.wav")
    puts 'Go get some, dawg.'
    exit!
  end

  def twilio_text(body)
    account_sid = 'AC2a63c8945c5ce051f44b775958aa850c'
    auth_token = '10145e00875e1bcf415f4d5e1a497351'
    client = Twilio::REST::Client.new(account_sid, auth_token)
    from = '++17573508918' 
    to = '+18609197401'
    client.messages.create(from: from, to: to, body: "#{body}")
  end

  puts 'pleh'

