require 'colorize'
require_relative "./board.rb"

class Tile
    attr_reader :value

    def initialize(board_of_tile)
        @value = "*"
        @board_of_tile = board_of_tile
    end

    def set_bomb
        @value = "B".colorize(:red)
    end
end