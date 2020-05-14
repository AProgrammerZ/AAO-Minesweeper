require_relative "./tile.rb"
require_relative "./board.rb"

b = Board.new

puts b.reveal_board

b.board.each_with_index do |row, idx|
    puts "Row #{idx}:"
    row.each do |square|                
        print square.neighbor_bomb_count        
    end  
    puts
end