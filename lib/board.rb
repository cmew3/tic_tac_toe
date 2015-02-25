class Board

  attr_reader :players, :turn_count, :grid

  def initialize player1, player2
    @grid=[[0,0,0],[0,0,0],[0,0,0]]
    @players=[player1,player2]
    @turn_count = 0

  end

  def place(player, coordinates)
    marker = player.symbol
    case marker
    when :nought
      grid[coordinates[:x]][coordinates[:y]]=1
    when :cross 
      grid[coordinates[:x]][coordinates[:y]] = -1
    end
    @turn_count += 1
  end

  def place_if_valid(player, coordinates)
    if grid[coordinates[:x]][coordinates[:y]]==0 
      place(player,coordinates)
    else
      puts 'that space is taken!'
    end

  end

  def row_scores 
    grid.map { |row| row.inject(:+) }
  
  end

    def column_scores 
    grid.transpose.map { |row| row.inject(:+) }
  
  end



end