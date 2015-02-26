require 'genius'

describe Genius do

    let(:grid)    { [[0,0,0],[0,0,0],[0,0,0]] }
    let(:board)   { double :board, grid: grid      }
    let(:monkey)  { Monkey.new("monkey",:nought)   }
    let(:genius)  { Genius.new("genius",:cross)    }

    context 'when playing a turn' do

      xit 'will win if it is able' do
        grid = [[1,-1,0],[1,-1,0],[0,0,0]]
        expect(genius.select_coordinate(board)).to eq({ x: 2, y: 0})
      end

    end

    xit 'is never beaten' do
      for i in 1..100
        board= Board.new(monkey,genius)
        board.play_game
        expect(board.winner).not_to be monkey
      end
    end
  
end