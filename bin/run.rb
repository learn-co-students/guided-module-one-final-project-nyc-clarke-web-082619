require_relative '../config/environment'
require 'pry'
ActiveRecord::Base.logger = nil


puts "Welcome To 💩   doku!!!"

puts "Let's get to know each other better - Please enter your name: "

name = gets.chomp
puts "Hey there, #{name}!!!!!!!!!!!!!!!!!!!!! Woo! Let's Play..."

user = Player.create(name: name)

b1 = Board.create(puzzle: " 💩96💩571💩💩💩4💩82💩9💩💩💩3💩💩💩💩5💩💩💩💩95💩💩4💩💩💩1💩💩💩💩💩9💩💩💩8💩💩26💩💩💩💩4💩💩💩💩2💩💩💩3💩79💩5💩💩💩126💩98💩", solution: " 296357148145826937837149526639581472512764398478392615964815723283479651751263984")
#b1 = Board.create(puzzle: " 29635714814582693783714952663958147251276439847839261596481572328347965175126398_", solution: " 296357148145826937837149526639581472512764398478392615964815723283479651751263984")
g1 = Game.create(player: user, board: b1)

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
