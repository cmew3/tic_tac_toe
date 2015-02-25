require 'player'

describe Player do

  context 'when created' do
    let(:player) { Player.new("Fred",:nought)}
    it 'has a name ' do
      expect(player.name).to eq "Fred"
    end

    it 'can be created as a nought' do
      expect(player.symbol).to eq :nought
    end

      
    it 'can be created as a cross' do
      player2 = Player.new("Kate",:cross)
      expect(player2.symbol).to eq :cross
    end

  end

  context 'when placing markers' do
    let(:board) {double :board, assign: 1}
    let(:player_nought) { Player.new("Fred",:nought)}
    let(:player_cross) { Player.new("Kate",:cross)}

    it 'can select the (0,2) coordinate to place a marker' do
      allow(player_nought).to receive(:gets).and_return("0","2")
      expect(player_nought.select_coordinate).to eq({x: 0, y: 2})
    end

  end
  
end