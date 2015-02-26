require 'player'

describe Player do

  context 'when created' do
    let(:player)  { Player.new("Fred",:nought)  }
    let(:player2) { Player.new("Kate",:cross)   }

    it 'has a name ' do
      expect(player.name).to eq "Fred"
    end

    it 'can be created as a nought' do
      expect(player.symbol).to eq :nought
    end
      
    it 'can be created as a cross' do
      expect(player2.symbol).to eq :cross
    end

  end

  context 'when placing markers' do
    let(:player_nought) { Player.new("Fred",:nought) }
    let(:board)         { double :board              }

    it 'can select the (0,2) coordinate to place a marker' do
      allow(STDOUT).to receive(:puts)
      allow(player_nought).to receive(:gets).and_return("0","2")

      expect(player_nought.select_coordinate(board)).to eq({x: 0, y: 2})
    end

  end
  
end