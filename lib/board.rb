class Board

  attr_reader :grid

  def initialize
    @grid=[[0,0,0],[0,0,0],[0,0,0]]

  end

  def is_winning_play?(direction, coords)
    grid_after_move = grid
    grid_after_move[coords[:x]][coords[:y]]=direction
    Board.line_scores(grid_after_move).include?(3*direction)
  end

  def self.row_scores square_array
    square_array.map { |row| row.inject(:+) }
  end

  def self.column_scores square_array
    square_array.transpose.map { |row| row.inject(:+) }
  end

  def self.diag_scores square_array
    dim = square_array.count-1
    diag1, diag2 = 0, 0
    for i in 0..dim
      diag1+=square_array[i][i]
      diag2+=square_array[i][dim-i]
    end
    [diag1,diag2]
  end

  def self.line_scores square_array 
    row_scores(square_array) + column_scores(square_array) + diag_scores(square_array)
  end


end