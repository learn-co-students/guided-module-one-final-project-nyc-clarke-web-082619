require_relative '../config/environment'
require 'pry'
require 'tty-prompt'
ActiveRecord::Base.logger = nil


def display_instructions
   puts "
         You don't know how to play 💩 -doku!? Come on!!!
         The Rules of Sudoku:

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
   
   puts "\n So, To get to that little ' 💩 ' in Block 6, you'd enter '6' when prompted for a block, a '5' for a position, and then your educated guess for a value"
end

puts "
      Welcome To 💩   doku!!!\n"

prompt = TTY::Prompt.new
choice = prompt.select("\nPick Something Already!!!") do |menu|
   menu.choice 'Login', 1
   menu.choice 'Create Account', 2
   menu.choice 'Instructions', 3
 end

 if choice == 1
   login 
 elsif choice == 2
   create_account
 elsif choice == 3
   display_instructions
 end

 #----------------------  Creating Account
puts "Let's get to know each other better - Please enter your name: "

name = gets.chomp
#--------------------------

#-------------- after logging in or creating account
puts "Hey there, #{name}!!!!!!!!!!!!!!!!!!!!! Woo! Let's Play..."
#-------------------


#---------- replace this stuff with class method DB pulls
# user = Player.create(name: name)

# b1 = Board.create(puzzle: " 💩96💩571💩💩💩4💩82💩9💩💩💩3💩💩💩💩5💩💩💩💩95💩💩4💩💩💩1💩💩💩💩💩9💩💩💩8💩💩26💩💩💩💩4💩💩💩💩2💩💩💩3💩79💩5💩💩💩126💩98💩", solution: " 296357148145826937837149526639581472512764398478392615964815723283479651751263984")
# #b1 = Board.create(puzzle: " 29635714814582693783714952663958147251276439847839261596481572328347965175126398_", solution: " 296357148145826937837149526639581472512764398478392615964815723283479651751263984")
# g1 = Game.create(player: user, board: b1)
   
def get_input
    user_input = []
    puts "Please enter a number (1-9) for the block:"
    user_input << gets.chomp
    puts "Please enter a number (1-9) for the position:"
    user_input << gets.chomp
    puts "Please enter a number (1-9) for the value you would like to enter:"
    user_input << gets.chomp
    user_input
end

def input_valid?(user_input)
    valid = true
    user_input.each do |number|
        if (1..9).include?(number.to_i) == false
            valid = false
        end
    end
    valid
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
    g1.board.display_board
    start_time = Time.now 
    turn(g1) until won?(g1)
    puts "Congrats, you ROCK!!!"
    end_time = Time.now 
    time = total_time(start_time, end_time)
    puts "You completed this puzzle in #{time}!"
 end
 play(g1)