class CommandLineInterface 

    def greet
        puts 'Welcome to the Mixer, the app that helps you clean out your pantry!'
    end

    def gets_user_input
        puts "We can help you find recipes using ingredients that are expiring in your pantry."
        puts "Enter an ingredient to get started:"
        user_input = gets.chomp
        user_input.capitalize
      end

end 