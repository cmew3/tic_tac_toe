class Player 

attr_reader :name, :symbol, :board


  def initialize name, symbol, board
    @name = name
    @symbol = symbol
    @board = board
  end

  def select_coordinate(x,y)
    board.place_if_valid(symbol,{x: x, y: y})
  end

end