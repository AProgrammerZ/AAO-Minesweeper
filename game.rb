require_relative "./board.rb"
require 'yaml'

class Game       
    def initialize
        n_or_l, filename = self.new_or_load
        
        if n_or_l == "n"
            @board = Board.new
            self.run
        elsif n_or_l == "l"
            saved_game = YAML::load(File.read("#{filename.strip}.yml"))
            saved_game.run
        end
    end

    def run                
        system "clear" 
        until @board.done? do
            @board.render
            r_f_or_s, row, col = get_user_input
            selected_square = @board.board[row.to_i][col.to_i] 
            
            if r_f_or_s == "r"
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
            elsif r_f_or_s == "f"
                selected_square.flag
            else
                self.save_game(row.strip)
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
        puts "followed by the coordinates of square, or new/old filename."
        puts "(For example: r, 2,3 OR f,4,6 OR s, minesweeper)."
        response = gets.chomp.split(",")            
        
        begin
            self.check_for_errors(response)
        rescue
            puts "Incorrect input. Please try again."
            sleep 1
            system "clear"
            @board.render
            response = self.get_user_input
        end
        
        response
    end

    def check_for_errors(response)        
        r_f_or_s, row, col = response
        
        raise "error" unless ["r", "f", "s"].include?(r_f_or_s)
        if r_f_or_s == "r" || r_f_or_s == "f"
            raise "error" unless ("0".."8").to_a.include?(row)           
            raise "error" unless ("0".."8").to_a.include?(col)
            
            raise "error" if r_f_or_s == "r" && @board.board[row.to_i][col.to_i].flagged?
            raise "error" if r_f_or_s == "f" && @board.board[row.to_i][col.to_i].revealed?   
            raise "error" if r_f_or_s == "r" && @board.board[row.to_i][col.to_i].revealed?                 
        end                  
    end

    def new_or_load
        system "clear"

        puts "Please enter if you would like to either start a new game or load a previously saved game."
        puts "If load, also enter the name of the saved game file."
        puts "(For example: n or l, bob)."
        n_or_l, filename = gets.chomp.split(",")
    end

    def save_game(filename)
        File.open("#{filename}.yml", "w") { |file| file.write(self.to_yaml) }
    end
end

if __FILE__ == $PROGRAM_NAME
  Game.new
end

                        # make a new branch
                        # then add functionality to new_or_load 
                        # for difficulty level (see game online)