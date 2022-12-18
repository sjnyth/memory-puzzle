require_relative './board.rb'
require_relative './card.rb'
require_relative './ComputerPlayer.rb'
require 'byebug'

class Game
    def initialize(n, player)
        @board = Board.new(n)
        @player = player
        @prev_guess = []
        @not_equal = false
        @show_and_hide = []
        @p = ComputerPlayer.new(@player, @board)
        @done = false
    end


    def make_guess(arr)
        if @prev_guess.length == 0
            a = @board.reveals(arr)
            
            @prev_guess = arr
            @p.fill_matched(a, @prev_guess)
        else
            

            if @board.grid[@prev_guess[0]][@prev_guess[1]] == @board.grid[arr[0]][arr[1]]
                @board.reveals(@prev_guess)
                b = @board.reveals(arr)
                @p.fill_matched(b, arr)
                @prev_guess = []
                @not_equal = false
                puts "Match"
            else
                @not_equal = true
                @p.matched.pop
                @board.reveals(@prev_guess)
                @board.reveals(arr)
                @show_and_hide << @prev_guess
                @show_and_hide << arr


                
            end

        end
    end



    def play
        @board.populate
        while !(@board.won?) || !(@done)
            sleep(0.5)
            print "\e[2J\e[f"
            @board.render
            
            if @not_equal
                a = @board.hide(@show_and_hide[0])
                b = @board.hide(@show_and_hide[1])
                puts "Sorry, Not a Match"
                sleep(0.5)
                print "\e[2J\e[f"
                @board.render
                @p.fill_guessed(a, b, @show_and_hide[0], @show_and_hide[1])
                @show_and_hide = []
                @prev_guess = []
                @not_equal = false
                
            end 

            if @board.won?
                @done = true
            end

            if !(@board.won?)
                arr = @p.guess()
                make_guess(arr)
            end


        end

        puts "Hey! You win"
    end

end


g = Game.new(4, 'Computer')
g.play