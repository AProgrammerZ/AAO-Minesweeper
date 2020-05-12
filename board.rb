require "byebug"

class Board
    def initialize
        @board = Array.new(9) {Array.new(9,"*")}
    end

    def seed_bombs
        bomb_count = 0
        until bomb_count == 10 do 
            random_row_num = rand(0...@board.length)
            random_tile_num = rand(0...@board.length)
            unless @board[random_row_num][random_tile_num] == "B"
                @board[random_row_num][random_tile_num] = "B" 
                bomb_count += 1
            end
        end
    end
end