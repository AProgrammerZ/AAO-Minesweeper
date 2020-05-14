require_relative "./tile.rb"
require_relative "./board.rb"


class Game    
    def initialize
        @board = Board.new
    end

    def run
        # until done do
        @board.render
        r_or_f, row, col = get_user_input 
        
        if r_or_f == "r"
            if @board.board[row][col].bombed?
                puts "Game over"
                break
            else
                
            end
        elsif r_or_f == "f"
            
        end

    end

    def get_user_input
        puts
        puts "Enter reveal or flag (r or f)"
        puts "followed by the coordinates of square"
        puts "(for example: r, 2,3)"
        gets.chomp.split(",")
        
        # add error checking

    end
end

Game.new.run