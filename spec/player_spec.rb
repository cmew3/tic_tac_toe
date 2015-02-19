require 'player'

describe Player do

  context 'when created' do
    let(:board) { double :board}
    let(:player) { Player.new("Fred",:nought, board)}
    it 'has a name ' do
      expect(player.name).to eq "Fred"
    end

    it 'has a board' do
      expect(player.board).to eq board
    end

    it 'can be created as a nought' do
      expect(player.symbol).to eq :nought
    end

      
    it 'can be created as a cross' do
      player2 = Player.new("Kate",:cross, board)
      expect(player2.symbol).to eq :cross
    end

  end

  context 'when placing markers' do
    let(:board) {double :board, assign: 1}
    let(:player_nought) { Player.new("Fred",:nought, board)}
    let(:player_cross) { Player.new("Kate",:cross, board)}

    it 'can select the (0,2) coordinate to place a marker' do
      expect(board).to receive(:place_if_valid).with(:nought, {x: 0, y:2})
      player_nought.select_coordinate(0,2)
    end

    it 'a nought player can places a nought marker' do
      expect(board).to receive(:place_if_valid).with(:nought,{x: 0, y:0})
      player_nought.select_coordinate(0,0)
    end

    it 'a cross player places a cross marker' do
      expect(board).to receive(:place_if_valid).with(:cross,{x: 1, y:2})
      player_cross.select_coordinate(1,2)
    end
  end
  
end