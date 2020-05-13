require "byebug"
require_relative "./tile.rb"

class Board
    def initialize
        @board = Array.new(9) {Array.new(9)}
        self.seed_bombs
    end

    def seed_bombs
        bomb_count = 0
        until bomb_count == 10 do 
            random_row_num = rand(0...@board.length)
            random_tile_num = rand(0...@board.length)
            unless @board[random_row_num][random_tile_num].value == "B"
                @board[random_row_num][random_tile_num].set_bomb 
                bomb_count += 1
            end
        end
    end
end