require_relative "./tile.rb"
require_relative "./board.rb"


class Game
    
    # delete after testing
    attr_reader :hidden_board

    def initialize
        @board = Board.new
        @hidden_board = @board.make_hidden_board
    end

    # def run
    #     until @board.done?

    #     end
    # end
end