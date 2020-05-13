require "byebug"
require 'colorize'
require_relative "./board.rb"

class Tile
    attr_reader :value

    def initialize(board_of_tile)
        @value = "*"
        @board_of_tile = board_of_tile
    end

    def inspect
        "#<Tile:#{self.object_id} @value='#{@value}'>"         
    end

    def set_bomb
        @value = "B".colorize(:red)
    end   

    # def neighbors
    #     neighbors = []

    #     # @board_of_tile.index(self)

    #     neighbors << 
    # end

    # def get_location
    #     debugger
    #     @board_of_tile.board.each_with_index do |row, idx|
    #         row.each do |square|                
    #             if square == self
    #                 return "location"
    #                 # return [idx][row.index(self)]
    #             end
    #         end            
    #     end
    #     return "couldnt find location"
    #     # @board_of_tile.index(self)
    # end    
end

# p Tile.new(Board.new)