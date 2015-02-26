require 'genius'

describe Genius do
    it 'is never beaten' do

    monkey=Monkey.new("monkey",:nought)
    genius=Genius.new("genius",:cross)
    for i in 1..100
      board= Board.new(monkey,genius)
      board.play_game
      expect(board.winner).not_to be monkey
    end
  end
  
end