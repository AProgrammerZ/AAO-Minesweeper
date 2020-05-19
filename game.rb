require_relative "./tile.rb"
require_relative "./board.rb"
require 'yaml'

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
            elsif r_or_f == "f"
                selected_square.flag
            else
                self.save_game
                puts "Game saved."
                sleep 1
            end            
            system "clear"
        end
        
        @board.render
        puts "You win!"        
    end

    def get_user_input
        puts
        puts "Enter reveal or flag/unflag or save (r or f or s)"
        puts "followed by the coordinates of square"
        puts "(for example: r, 2,3)"
        response = gets.chomp.split(",")            
        
        begin
            self.check_for_errors(response)
        rescue
            puts "Incorrect input. Please try again."
            sleep 1
            system "clear"
            @board.render
            self.get_user_input
        end
        
        response
    end

    def check_for_errors(response)        
        r_or_f, row, col = response
        
        raise "error" unless ["r", "f", "s"].include?(r_or_f)
        if r_or_f == "r" || r_or_f == "f"
            raise "error" unless (0..8).to_a.include?(row.to_i)           
            raise "error" unless (0..8).to_a.include?(col.to_i)
            
            raise "error" if r_or_f == "r" && @board.board[row.to_i][col.to_i].flagged?
        end                  
    end

    def save_game
        File.open("minesweeper.yml", "w") { |file| file.write(self.to_yaml) }
    end
end

Game.new.run

# If loading a saved game:

# saved_game = YAML::load(File.read("minesweeper.yml"))
# saved_game.run