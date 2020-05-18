require_relative "./tile.rb"
require_relative "./board.rb"


class Game        
    def initialize
        @board = Board.new
    end

    def run
        until self.done? do
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
                    # selected_square.neighbors.each(&:reveal) if selected_square.neighbor_bomb_count == 0
                    # self.reveal_neighbors(selected_square.neighbors)
                    self.reveal_neighbors(selected_square)
                end
            # elsif r_or_f == "f"
                

            # end            
            system "clear"
            end            
        end
        
        @board.render
        puts "You win!"        
    end

    def get_user_input
        puts
        puts "Enter reveal or flag (r or f)"
        puts "followed by the coordinates of square"
        puts "(for example: r, 2,3)"
        gets.chomp.split(",")
        
        # add error checking

    end

    def done?
        bomb_free_squares = @board.board.flatten.reject(&:bombed?)
        bomb_free_squares.all?(&:revealed?)
    end

# recursive way. didnt work
    # def reveal_neighbors(neighbors)
    #     # base case
    #     return if neighbors.empty?        

    #     neighbors.each do |square|
    #         next_neighbors = []
    #         square.neighbors.each do |square_neighbor| 
    #             unless square_neighbor.bombed?
    #                 square_neighbor.reveal 
    #                 next_neighbors << square_neighbor
    #             end                 
    #         end
    #         reveal_neighbors(next_neighbors)
    #     end        
    # end

    def reveal_neighbors(square)
        # debugger
        return if square.neighbors.any?(&:bombed?)
        return if square.neighbors.any? { |neighbor| neighbor == nil }  
        # return if square.neighbors.all?(&:revealed?)
        # return if square.neighbors.all?(&:bombed?)
        
        square_neighbors = square.neighbors
        square_neighbors.each do |square_neighbor| 
            unless square_neighbor.bombed? || square_neighbor.revealed?
                square_neighbor.reveal
                reveal_neighbors(square_neighbor)
            end
        end
    end
end

Game.new.run