class HumanPlayer
    def initialize(name)
        @name = name
    end

    def guess
        puts "Enter your guess in '3,5' pattern"
        input = gets.chomp
        arr = input.split(',')
        arr[0] = arr[0].to_i
        arr[1] = arr[1].to_i
        return arr

    end
end