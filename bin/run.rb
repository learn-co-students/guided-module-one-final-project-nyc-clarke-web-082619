require_relative '../config/environment'
require 'pry'
require 'tty-prompt'
ActiveRecord::Base.logger = nil

   system'clear'

   puts "
      Welcome To 💩 -doku!!!\n"

def display_instructions
   puts "
         You don't know how to play 💩 -doku!? Come on!!!
         The Rules of 💩 -doku:

         The classic Sudoku game involves a grid of 81 squares.
         The grid is divided into nine blocks, each containing nine squares.

         The rules of the game are simple: 
         1. each of the nine blocks has to contain all the numbers 1-9 within its squares. 
         2. Each number can only appear once in a row, column or box.

         The difficulty lies in that each vertical nine-square column, 
         or horizontal nine-square line across, within the larger square, 
         must also contain the numbers 1-9, without repetition or omission.

         Every puzzle has just one correct solution."

   puts "\nFilling out the board:

          For each turn, enter three integers: one for the block of your choice, 
          one for the position in that block, and finally one for the value you would like to input.  
          Continue until the board is full and the game is complete!"

   puts "\nFor example: " 
   puts "                    ================================================"
   puts "                    ||  This     ||    |         |   || 1 | 2 | 3 ||"
   puts "    Block 1 =====>  ||  is a     ||    |         |   || 4 | 5 | 6 || <==== These are positions"
   puts "                    ||  block    ||    | Block 2 |   || 7 | 8 | 9 ||"
   puts "                    ================================================"
   puts "                    || |       | ||    |         |   ||   |   |   ||"
   puts "                    || |       | ||    |         |   ||   |💩  |   || "
   puts "                    || |Block 4| ||    | Block 5 |   ||  Block 6  ||"
   puts "                    ================================================"
   puts "                    || |       | ||    |         |   || |       | ||"
   puts "                    || |       | ||    |         |   || |       | ||"
   puts "                    || |Block 7| ||    | Block 8 |   || |Block 9| ||"
   puts "                    ================================================"
   
   puts " 💩 -doku uses those same rules, but with  💩  instead of black spaces!"
   puts "\n So, To get to that little ' 💩 ' in Block 6, you'd enter '6' when prompted for a block, a '5' for a position, and then your educated guess for a value"
   enter_menu
end

def validate_user(name)
   if Player.find_by_name(name)
      true
   else
      false
   end
end

def input_valid?(user_input)
   user_input.each do |number|
      (1..9).include?(number.to_i)
   end
end

def get_user_input
   user_input = gets.chomp 
   if user_input == 'menu'
      system 'clear'
      enter_menu
   elsif user_input == 'quit'
      system(exit)
   elsif (1..9).include?(user_input.to_i)
      user_input
   else
      puts "invalid input"
      get_user_input
   end 
end

def get_input
   puts "Please follow the prompts, or type 'menu' to go back to menu:"
    user_input = []
    puts "Please enter a number (1-9) for the block:"
    user_input << get_user_input
    puts "Please enter a number (1-9) for the position you would like to enter:"
    user_input << get_user_input
    puts "Please enter a number (1-9) for the value you would like to enter:"
    user_input << get_user_input 
end

def input_to_index(user_input)
    block = (user_input[0].to_i - 1) * 9
    index = block + user_input[1].to_i
    index
end

def position_available?(puzzle_string, index)
    !((1..9).include?(puzzle_string[index].to_i))
end

def check_against_solution(solution_string, index, value)
   if solution_string[index] == value
          return true
   else 
          return false
     end
end

def valid_move?(user_input, game)
    user_index = input_to_index(user_input)
    input_valid?(user_input) && position_available?(game.board.puzzle, user_index) && check_against_solution(game.board.solution, user_index, user_input[2])
end

def move(board, user_input) 
    board.puzzle[input_to_index(user_input)] = user_input[2]
    return board.puzzle
 end

 def updated_display_board(board) 
    system 'clear'
    board.display_board
 end
 
 def turn(game)
    user_input = get_input
    if valid_move?(user_input, game) 
        move(game.board, user_input) 
        updated_display_board(game.board)
        congrats = ["Good Job!🎉!!!!🔥!!!!😍", "Yeah!!!😃  😊  👍", "Way to go, Champ!🎉 🥇 🏆 🎉 🥇 🏆 🎉 !!!", "Nice work, I guess 🙄 ... "]
        puts congrats.sample
    else
       updated_display_board(game.board)
       wrong = ["WRONG!!!!! 👎  👎  👎  👎  👎  👎.  ", "Nope! 👺  👹  ❌", "Guess again! 🙅‍♀️  🙅‍♂️  🙅‍♀️  🙅‍♂️."]
       puts wrong.sample
       turn(game)
    end
 end
 def won?(g1)
    g1.board.puzzle == g1.board.solution
 end

 def total_time(start_time, end_time)
    total_time = Time.diff(Time.parse("#{start_time}"), Time.parse("#{end_time}"), '%h:%m:%s')
    total_time[:diff]
 end
 def play(g1)
    system'clear'
    g1.board.display_board
    g1.start_time = Time.now 
    turn(g1) until won?(g1)
    good_job = ["Congrats, you ROCK!!!", "I wish my kids were as smart as you...", "Wowee Zowee, you sure are great!!!", "You finished that much faster than that other guy... "]
    puts good_job.sample
    g1.end_time = Time.now 
    g1.total_time = total_time(g1.start_time, g1.end_time)
    puts "You completed this puzzle in #{g1.total_time}!"
    g1.save
 end

 def login(name)
   if validate_user(name)
      puts "Welcome Back, #{name}! Picking a board..."
      user = Player.find_by_name(name)
      user
   else
      system'clear'
      puts "Hey, you don't have an account! Select 'Create Account' instead"
      account_menu(name)
   end
 end

 def create_account(name)
   if !validate_user(name)
      sleep(1)
       puts "Hey there, #{name}!!!!!!!!!!!!!!!!!!!!! "
       puts "Woo! Creating an account.... "
       sleep(1)
       puts "PROCESSING!!!!!!!!"
       sleep(2)
       puts "Account created. Let's pick a board..."
       user = Player.create(name: name)
       user.save
       user
   else
      sleep(1)
      system'clear'
      puts "Sorry, that name is already taken\n"
      account_menu(name)
   end
 end

 def account_menu(name)
   account_prompt = TTY::Prompt.new
   choice = account_prompt.select("Make your choice:") do |menu|
      menu.choice 'Login', -> {login(name)}
      menu.choice 'Create Account', -> {create_account(name)}
   end
 end

 def board_menu
   board_prompt = TTY::Prompt.new
   choice = board_prompt.select("") do |menu|
      menu.choice 'Easy', -> {Board.get_difficulty("Easy")} 
      menu.choice 'Medium', -> {Board.get_difficulty("Medium")}
      menu.choice 'Hard', -> {Board.get_difficulty("Hard")}
   end  
 end 

 def play_again_menu(user)
   play_prompt = TTY::Prompt.new
   choice = play_prompt.select('') do |menu|
      menu.choice 'Play Again?', -> {play_again(user)}
      menu.choice 'Logout', -> {enter_menu}
      menu.choice 'Quit', -> {system(exit)}
   end
 end

 def play_again(user)
      if user.name == "demo"
         levels = Board.find_by(puzzle: " 2963571481458269378371💩952663958147251276439847💩392615964815723283479651751263984")
      else 
         levels = board_menu 
      end
   g1 = Game.create(player: user, board: levels)
   play(g1)
   play_again_menu(user)
 end
 
 def start
   sleep(1)
   puts "\nLet's get to know each other better - Please enter your name, or type 'quit' to exit the program"
   name = gets.chomp
      if name == 'quit'
         system(exit)
      end
   puts "Hey there, #{name}!!!!!!!!!!!!!!!!!!!!!"
   sleep(1)
   user = account_menu(name)  
   play_again(user)
 end

 def enter_menu
   prompt = TTY::Prompt.new
   choice = prompt.select("\nPick Something Already!!!") do |menu|
      menu.choice 'Accounts', -> {start}
      menu.choice 'Instructions', -> {display_instructions}
      menu.choice 'Quit', -> {system(exit)}
   end
end
enter_menu  