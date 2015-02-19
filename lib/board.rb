class Board < Array

  def initialize
    @grid = Array.new(3,Array.new(3,0))

  end

  def grid
    @grid
  end

  def place(symbol, coordinates)
    
    case symbol
    when :nought 
        grid[coordinates[:x]][coordinates[:y]]=1
    when :cross 
      grid[coordinates[:x]][coordinates[:y]] = -1
    end

  end

  def place_if_valid(symbol, coordinates)
    raise 'that space is taken!' unless grid[coordinates[:x]][coordinates[:y]]==0
    place(symbol,coordinates)
  end

end