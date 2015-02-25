class Computer < Player
  def select_coordinate
    { x: rand(3), y: rand(3)}
  end
end