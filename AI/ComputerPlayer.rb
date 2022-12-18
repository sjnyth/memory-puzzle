class ComputerPlayer 
    
    attr_accessor :matched, :upto
    def initialize(name, board)
        @name = name
        @matched = []
        @upto = Hash.new()
        @grid = board
        @first_guess = true
        @has_found_a_pair = false
        @pair = []

    end

    def guess
        


        if (@first_guess)
            if @upto.empty?
                found = false
                while !found
                    rand1 = rand(0..@grid.length - 1)
                    rand2 = rand(0..@grid.length - 1)
                    if @matched.all? {|arr| arr[1] != [rand1, rand2]}
                        found = true
                        @first_guess = false
                        return [rand1, rand2]
                    end
                end
            else
                new_hash = Hash.new(0)
                @upto.each do |k, v|
                    new_hash[v] += 1
                end

                if new_hash.any? {|k, v| v >= 2}
                    a = 0
                    new_hash.each do |k, v|
                        if v >= 2
                            a = k
                            has_found_a_pair = true
                            break
                        end
                    end
                    @upto.each do |k, v|
                        if k == a
                            @pair << k
                        end
                    end
                    @first_guess = false
                    return @pair[0]
                else
                    found = false
                    while !found
                        rand1 = rand(0..@grid.length - 1)
                        rand2 = rand(0..@grid.length - 1)
                        if @matched.all? {|arr| arr[1] != [rand1, rand2]}
                            found = true
                            @first_guess = false
                            return [rand1, rand2]
                        end
                    end
                end
            end
        else
            if @has_found_a_pair
                a = @pair[1]
                @pair = []
                @has_found_a_pair = false
                @first_guess = true
                return a
            else
                
                if @matched.length != 0
                    a = @matched[-1][0]
                    @upto.each do |k, v|
                        if v == a
                            @first_guess = true
                            @pair = []
                            @has_found_a_pair = false
                            return k
                        end
                    end
                end
                @first_guess = true
                @pair = []
                @has_found_as_pair = false
                found = false
                while !found
                    rand1 = rand(0..@grid.length - 1)
                    rand2 = rand(0..@grid.length - 1)
                    if @matched.all? {|arr| arr[1] != [rand1, rand2]}
                        found = true
                        return [rand1, rand2]
                    end
                end
            end

                
        end



                
                



    end


    def fill_matched(a, pos)
        @matched << [a, pos]
    end


    def fill_guessed(a, b, pas_a, pas_b)
        @upto[pas_a] = a
        @upto[pas_b] = b

    end


end