require "byebug"
require 'colorize'
require_relative "./board.rb"

class Tile
    attr_accessor :value

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

    def neighbors
        neighbors = []

        my_row, my_col = self.location        

        # maybe make this recursive or a loop

        neighbors << @board_of_tile[my_row][my_col+1] unless my_col == 8 
        neighbors << @board_of_tile[my_row][my_col-1] unless my_col == 0
        
        unless my_row == 0
            neighbors << @board_of_tile[my_row-1][my_col]
            neighbors << @board_of_tile[my_row-1][my_col+1] unless my_col == 8
            neighbors << @board_of_tile[my_row-1][my_col-1] unless my_col == 0
        end

        unless my_row == 8
            neighbors << @board_of_tile[my_row+1][my_col]
            neighbors << @board_of_tile[my_row+1][my_col+1] unless my_col == 8
            neighbors << @board_of_tile[my_row+1][my_col-1] unless my_col == 0
        end

        # neighbors.map(&:location)
        neighbors
    end

    def location
        @board_of_tile.each_with_index do |row, idx|
            row.each do |square|                
                if square == self
                    return [idx, row.index(self)]
                end
            end            
        end
    end    

    def neighbor_bomb_count
        neighbors = self.neighbors

        neighbors.count { |tile| tile.value == "B".colorize(:red) }
    end
end