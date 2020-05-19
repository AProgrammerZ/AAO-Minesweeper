require_relative "./tile.rb"
require_relative "./board.rb"


class Game        
    def initialize
        @board = Board.new
    end

    def run
        until @board.done? do
            @board.render
            r_or_f, row, col = get_user_input
            selected_square = @board.board[row.to_i][col.to_i] 
            
            if r_or_f == "r"
                if selected_square.bombed?
                    system "clear"
                    all_bombed_squares = @board.board.flatten.select(&:bombed?)
                    all_bombed_squares.each(&:reveal)
                    @board.render
                    puts "You lost."
                    return 
                else
                    selected_square.reveal                    
                    @board.reveal_neighbors(selected_square)
                end
            else
                selected_square.flag
            end            
            system "clear"
        end
        
        @board.render
        puts "You win!"        
    end

    def get_user_input
        puts
        puts "Enter reveal or flag/unflag (r or f)"
        puts "followed by the coordinates of square"
        puts "(for example: r, 2,3)"
        gets.chomp.split(",")
        
        # add error checking (maybe put in a seperate method)
        # also for checking if input of "r" for a flagged position

    end                    
end

Game.new.run