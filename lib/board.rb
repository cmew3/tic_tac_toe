class Board

  attr_reader :grid

  def initialize
    @grid=[[0,0,0],[0,0,0],[0,0,0]]

  end


  def row_scores 
    grid.map { |row| row.inject(:+) }
  end

  def column_scores 
    grid.transpose.map { |row| row.inject(:+) }
  end

  def diag_scores 
    diag1, diag2 = 0, 0
    for i in 0..2
      diag1+=grid[i][i]
      diag2+=grid[i][2-i]
    end
    [diag1,diag2]
  end

  def line_scores 
    row_scores + column_scores + diag_scores
  end

end