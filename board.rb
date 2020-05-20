require "byebug"
require 'colorize'
require_relative "./tile.rb"

class Board
    attr_reader :board

    def initialize
        @board = Array.new(9) { Array.new(9) }
        self.fill_with_Tiles
        self.seed_bombs
        self.set_fringe_and_interior_tiles
    end

    def fill_with_Tiles
        @board.map! { |row| row.map! { |square| Tile.new(@board) } }            
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

    def set_fringe_and_interior_tiles
        @board.each do |row|
            row.each do |square|
                square.value = square.neighbor_bomb_count unless square.bombed?
                square.value = "_" if square.value == 0
            end
        end
    end

    # delete after testing

                    # use this to test if game stops after winning

    # def reveal_board
    #     print "  "
    #     (0...@board.length).each { |num| print "#{num.to_s.colorize(:yellow)} " }
    #     puts
    #     @board.each_with_index do |row, idx|
    #         print "#{idx.to_s.colorize(:yellow)} "
    #         row.each do |square|
    #             if square.bombed?
    #                 print "#{square.value.colorize(:red)} " 
    #             else
    #                 print "#{square.value} " 
    #             end
    #         end
    #         puts
    #     end
    #     return
    # end

    def render
        print "  "
        (0...@board.length).each { |num| print "#{num.to_s.colorize(:yellow)} " }
        puts
        @board.each_with_index do |row, idx|
            print "#{idx.to_s.colorize(:yellow)} "
            row.each do |square|
                if square.revealed?
                    if square.bombed?
                        print "#{square.value.colorize(:red)} "                     
                    else
                        print "#{square.value} " 
                    end
                elsif square.flagged?
                    print "F ".colorize(:green)
                else
                    print "* "
                end
            end
            puts
        end
        return
    end    

    def done?
        bomb_free_squares = @board.flatten.reject(&:bombed?)
        bomb_free_squares.all?(&:revealed?)
    end
                                                                               
    def reveal_neighbors(square)
        return if square.neighbors.any?(&:bombed?)
        return if square.neighbors.all?(&:revealed?)        
        # didnt work:
        # return if square.neighbors.all? { |neighbor| neighbor.value.is_a? Numeric || neighbor.revealed? }
        
        square.neighbors.each do |square_neighbor| 
            unless square_neighbor.bombed? || square_neighbor.revealed? || square_neighbor.flagged?
                square_neighbor.reveal
                reveal_neighbors(square_neighbor)
            end
        end
    end
end