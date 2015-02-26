class Monkey < Player
  def select_coordinate
    { x: Kernel.rand(3), y: Kernel.rand(3)}
  end
end