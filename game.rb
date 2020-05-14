require_relative "./tile.rb"
require_relative "./board.rb"

# first square's neighbors
Board.new.board.each_with_index do |row, idx|
    puts "Row #{idx}:"
    row.each do |square|                
        p square.neighbors
        puts
    end  
end