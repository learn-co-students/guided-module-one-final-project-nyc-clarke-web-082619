require_relative 'config/environment'

puts "Welcome To Sudoku!!!"

puts "Let's get to know each other better - Please enter your name: "

name = gets.chomp
puts "Hey there, #{name}!!!!!!!!!!!!!!!!!!!!! Woo! Let's Play..."


#tty-prompt for menu

#  - instructions menu
#  - select difficulty
#  - exit

# After selecting username and board to play, game = Game.create(player: user, board: board)
# game.board.display_board or game.display_board?

## gathering and checking user_input for validity
# --------------------------------------------------------------------------
# bundle this whole process in a method

# use a loop that sets a variable = false

# while variable is false, request input, check input for validity, if it is valid, set variable = true, else loop runs again

# user enters all three numbers, run check_input. if it returns true it is valid, else it is invalid

# user_input = [] # at the end of a loop, if input was invalid, clear the array

# puts "Enter block number: 
# user_input << gets.chomp

# puts "Enter square position: "
# user_input << square

# puts "Enter value: "
## user_input << value

game = Game.create(player: name, board: b1)


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

user_input = get_input

def input_valid?(user_input)
    valid = true
    user_input.each do |number|
        if (1..9).include?(number) == false
            valid = false
        end
    end
    valid
end

# convert position into index
def input_to_index(user_input)
    block = (user_input[0] - 1) * 9
    index = block + user_input[1]
    index
end

# check if the value of the puzzle at that index is already defined
def position_available?(puzzle_string, index)
    !((1..9).include?(puzzle_string[index].to_i))
end

# use that position to check if user input value is correct
def check_against_solution(solution_string, index, value)
   if solution_string[index] == value
          true
   else 
          false
     end
end

def valid_move?(user_input)
    user_index = input_to_index(user_input)
    input_valid?(user_input) && position_available?(game.board.puzzle, user_index) && check_against_solution(game.board.solution, user_index, user_input[2])
end
# else
#    puts "sorry! try again!"
#    runs the whole process again


# some sort o' loop method that runs the game, asking for new input until all spaces have been filled
# condition = check board against solution, if ==, the board is full, game is over, calculate stuff

#congrats!!
def move(board, user_input) #update string with number @ position; push into string
    board.puzzle[input_to_index] = user_input[2]
    return board.puzzle
 end
 def updated_display_board(board) #clear terminal and display updated board  << pass in a board
    system('cls') #code to clear terminal?
    board.display_board
 end
 
 def turn(board)
    user_input = get_input
    if valid_move?(user_input) #verify arguments with Tom
        move(game.board, user_input) #arguments  <<specify board, and user_input[2]
        updated_display_board(board)
    else
        turn
    end
 end
 def won?
    self.board.puzzle == self.board.solution
 end
 # gem install time_diff
 # require 'time_diff'
 def total_time(start_time, end_time)
    total_time = Time.diff(Time.parse(start_time), Time.parse(end_time), '%H %N %S')
    total_time[:diff]
 end
 def play
    start_time = Time.now #fix timer method
    turn until won?
    puts "Congrats, you ROCK!!!"
    end_time = Time.now #(.strftime("%H:%M:%S"))
    time = total_time(start_time, end_time)
    puts "You completed this puzzle in #{time}!"
 end
 