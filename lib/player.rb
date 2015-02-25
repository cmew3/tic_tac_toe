class Player 

attr_reader :name, :symbol


  def initialize name, symbol
    @name = name
    @symbol = symbol
  end

  def select_coordinate
    # board.place_if_valid(symbol,{x: x, y: y})
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    { x: x, y: y}
  end

end