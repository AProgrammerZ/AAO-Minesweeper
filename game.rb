require_relative "./tile.rb"
require_relative "./board.rb"


class Game    
    def initialize
        @board = Board.new
        @hidden_board = @board.make_hidden_board
    end

    def run
        get_user_input
    end

    def get_user_input
        puts
        puts "Enter reveal or flag (r or f)"
        puts "followed by the coordinates of square"
        puts "(for example: r, 2,3)"
        r_or_f, row, col = gets.chomp.split(",")
    end
end

Game.new.run

# add revealed? method to tile (see Hints section from AAO)