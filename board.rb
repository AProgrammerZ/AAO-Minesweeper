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
                square.value = square.neighbor_bomb_count unless square.value == "B".colorize(:red)
                square.value = "_" if square.value == 0
            end
        end
    end

    def reveal_board
        print "  "
        (0...@board.length).each { |num| print "#{num.to_s.colorize(:yellow)} " }
        puts
        @board.each_with_index do |row, idx|
            print "#{idx.to_s.colorize(:yellow)} "
            row.each do |square|
                print "#{square.value} "
            end
            puts
        end
        return
    end

    def make_hidden_board
        hidden_board = []
        
        @board.each do |row|
            new_row = []
            row.each do |square|
                new_row << "*"
            end
            hidden_board << new_row
        end

        hidden_board
    end    
end