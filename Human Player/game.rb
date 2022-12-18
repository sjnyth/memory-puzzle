require_relative './board.rb'
require_relative './card.rb'
require_relative './HumanPlayer.rb'
require 'byebug'

class Game
    def initialize(n, player)
        @board = Board.new(n)
        @player = player
        @prev_guess = []
        @not_equal = false
        @show_and_hide = []
    end


    def make_guess(arr)
        if @prev_guess.length == 0
            @board.reveals(arr)
            @prev_guess = arr
        else
            

            if @board.grid[@prev_guess[0]][@prev_guess[1]] == @board.grid[arr[0]][arr[1]]
                @board.reveals(@prev_guess)
                @board.reveals(arr)
                @prev_guess = []
                @not_equal = false
                puts "Match"
            else
                @not_equal = true
                @board.reveals(@prev_guess)
                @board.reveals(arr)
                @show_and_hide << @prev_guess
                @show_and_hide << arr


                
            end

        end
    end



    def play
        @board.populate
        p = HumanPlayer.new(@player)
        while !(@board.won?)
            sleep(0.5)
            print "\e[2J\e[f"
            @board.render

            if @not_equal
                @board.hide(@show_and_hide[0])
                @board.hide(@show_and_hide[1])
                puts "Sorry, Not a Match"
                sleep(0.5)
                print "\e[2J\e[f"
                @board.render
                @show_and_hide = []
                @prev_guess = []
                @not_equal = false
            end 
            
            


            arr = p.guess()
            make_guess(arr)
        end

        puts "Hey! You win"
    end

end


g = Game.new(4, 'human')
g.play