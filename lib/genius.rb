require 'player'

class Genius < Player

  def select_coordinate grid
    { x: Kernel.rand(3), y: Kernel.rand(3)}
  end

end