require_relative './card.rb'

class Board

    attr_accessor :grid, :size
    def initialize(n)
        @grid = Array.new(n) {Array.new}
        @size = n
    end

    def populate
        arr = 'abcdefghijklmnopqrstuvwxyz'.split('')
        words = []
        while words.length < ((@size * @size) / 4)
            le = arr.sample
            if !words.include?(le)
                words << le
            end
        end

        words.each do |c_value|
            count = 0
            until count == 4 do
                i = rand(0..@size - 1)
                j = rand(0..@size  -1)
                if !(@grid[i][j])
                    @grid[i][j] = Card.new(c_value)
                    count += 1
                end
            end
        end

       
    end

    def render
        leng = @grid.length
        i = 0
        puts
        while i < leng
            if i == 0

                print "\t" + i.to_s  + "\t"
            else
                print i.to_s  + "\t"
            end
            
            i += 1
        end
        puts
        puts
        @grid.each_with_index do |sub, index|
            puts index.to_s + "\t" + sub.map {|card| card.to_s}.join("\t")
            puts
        end
    end
    
    def won?
        @grid.all? {|sub| sub.all?{|card| card.face_up == true}}
    end

    def reveals(guess_pos)
        i, j = guess_pos
        if !(@grid[i][j].face_up)
            @grid[i][j].reveal
        end
        return @grid[i][j].face_value

        
    end

    def hide(arr)
        i, j = arr
        @grid[i][j].hide
    end

end