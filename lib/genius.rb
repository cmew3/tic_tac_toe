require 'player'

class Genius < Player

  def select_coordinate board
    board.grid.each do |row|
      row.each do |column|
        if board.is_winning_play?(symbol_to_i, {x: row, y: column })
          return {x: row, y: column }
        end
      end 
    end
    { x: Kernel.rand(3), y: Kernel.rand(3)}
  end

end