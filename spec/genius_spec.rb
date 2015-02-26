require 'genius'

describe Genius do

    let(:grid)    { double :grid                   }
    let(:monkey)  { Monkey.new("monkey",:nought)   }
    let(:genius)  { Genius.new("genius",:cross)    }

    xit 'is never beaten' do
      for i in 1..100
        board= Board.new(monkey,genius)
        board.play_game
        expect(board.winner).not_to be monkey
      end
    end
  
end