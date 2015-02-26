require 'player'

class Monkey < Player
  def select_coordinate board
    { x: Kernel.rand(3), y: Kernel.rand(3)}
  end
end