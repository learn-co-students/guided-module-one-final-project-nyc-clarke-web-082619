class Board < ActiveRecord::Base
    has_many :games
    has_many :players, through: :games 


    def display_board

        
        puts "The best time for this board is:  #{best_time}   "
       

        board1 = self.puzzle
        puts "=================================================="
        puts "|| #{board1[1]}  | #{board1[2]}  | #{board1[3]}  || #{board1[10]}  | #{board1[11]}  | #{board1[12]}  || #{board1[19]}  | #{board1[20]}  | #{board1[21]}  ||"
        puts "|| #{board1[4]}  | #{board1[5]}  | #{board1[6]}  || #{board1[13]}  | #{board1[14]}  | #{board1[15]}  || #{board1[22]}  | #{board1[23]}  | #{board1[24]}  ||"
        puts "|| #{board1[7]}  | #{board1[8]}  | #{board1[9]}  || #{board1[16]}  | #{board1[17]}  | #{board1[18]}  || #{board1[25]}  | #{board1[26]}  | #{board1[27]}  ||"
        puts "=================================================="
        puts "|| #{board1[28]}  | #{board1[29]}  | #{board1[30]}  || #{board1[37]}  | #{board1[38]}  | #{board1[39]}  || #{board1[46]}  | #{board1[47]}  | #{board1[48]}  ||"
        puts "|| #{board1[31]}  | #{board1[32]}  | #{board1[33]}  || #{board1[40]}  | #{board1[41]}  | #{board1[42]}  || #{board1[49]}  | #{board1[50]}  | #{board1[51]}  ||"
        puts "|| #{board1[34]}  | #{board1[35]}  | #{board1[36]}  || #{board1[43]}  | #{board1[44]}  | #{board1[45]}  || #{board1[52]}  | #{board1[53]}  | #{board1[54]}  ||"
        puts "=================================================="
        puts "|| #{board1[55]}  | #{board1[56]}  | #{board1[57]}  || #{board1[64]}  | #{board1[65]}  | #{board1[66]}  || #{board1[73]}  | #{board1[74]}  | #{board1[75]}  ||"
        puts "|| #{board1[58]}  | #{board1[59]}  | #{board1[60]}  || #{board1[67]}  | #{board1[68]}  | #{board1[69]}  || #{board1[76]}  | #{board1[77]}  | #{board1[78]}  ||"
        puts "|| #{board1[61]}  | #{board1[62]}  | #{board1[63]}  || #{board1[70]}  | #{board1[71]}  | #{board1[72]}  || #{board1[79]}  | #{board1[80]}  | #{board1[81]}  ||"
        puts "=================================================="
    end

    def self.get_difficulty(difficulty)
        Board.all.select {|board| board.difficulty == "#{difficulty}"}.sample
    end 

    def get_times
        Game.all.collect {|game| game.total_time if game.board == self}.select {|time| time != nil}
    end

    def best_time
        total_times = self.get_times
        total_times.min
    end




end