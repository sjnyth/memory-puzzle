class Card

    attr_reader :face_value, :face_up
    def initialize(face_value)
        @face_value = face_value
        @face_up = false
    end

    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end

    def to_s
        if @face_up
            return @face_value
        else
            return ' '
        end
    end

    def ==(obj)
        return @face_value.eql?(obj.face_value)
    end
        
end