require_relative "./tile.rb"
require_relative "./board.rb"


Board.new.board.each_with_index do |row, idx|
    row.each do |square|                
        print square.get_location       
    end
    puts
end