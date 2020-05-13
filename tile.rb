require 'colorize'

class Tile
    attr_reader :value

    def initialize
        @value = "*"
    end

    def set_bomb
        @value = "B".colorize(:red)
    end
end