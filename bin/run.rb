require_relative '../config/environment'
require 'pry'

puts "Welcome To Sudoku!!!"

puts "Let's get to know each other better - Please enter your name: "

name = gets.chomp
puts "Hey there, #{name}!!!!!!!!!!!!!!!!!!!!! Woo! Let's Play..."

user = Player.create(name: name)
b1 = Board.create(puzzle: " _96_571___4_82_9___3____5____95__4___1_____9___8__26____4____2___3_79_5___126_98_", solution: " 296357148145826937837149526639581472512764398478392615964815723283479651751263984")
g1 = Game.create(player: user, board: b1)

#bin/run.rb:99:in `play': undefined local variable or method `b1' for main:Object (NameError)

#tty-prompt for menu

#  - instructions menu
#  - select difficulty
#  - exit

# After selecting username and board to play, game = Game.create(player: user, board: board)
# game.board.display_board or game.display_board?

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
    binding.pry
    return board.puzzle
    binding.pry
 end
 def updated_display_board(board) 
    system('cls') 
    board.display_board
 end
 
 def turn(game)
    user_input = get_input
    if valid_move?(user_input, game) 
        move(game.board, user_input) 
        updated_display_board(game.board)
    else
       puts "WRONG!!!!!!!"
       turn(game)
    end
 end
 def won?(g1)
    g1.board.puzzle == g1.board.solution
 end

 def total_time(start_time, end_time)
    total_time = Time.diff(Time.parse(start_time), Time.parse(end_time), '%H %N %S')
    total_time[:diff]
 end
 def play(g1)
    g1.board.display_board
    start_time = Time.now 
    turn(g1) until won?(g1)
    binding.pry
    puts "Congrats, you ROCK!!!"
    binding.pry
    end_time = Time.now 
    binding.pry
    time = total_time(start_time, end_time)
    binding.pry
    puts "You completed this puzzle in #{time}!"
    binding.pry
 end
 play(g1)
