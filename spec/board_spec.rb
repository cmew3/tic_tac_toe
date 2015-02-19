require 'board'

describe Board do

  context 'before the game starts' do
    let(:board) { Board.new}

    it 'has three rows' do
      expect(board.grid.count).to eq 3
    end

    it 'each row has three columns' do
      board.grid.each do |row|
        expect(row.count).to eq 3
      end
    end

    it 'has only zeroes' do
      expect(board.grid.flatten.inject(:+)).to eq 0
    end

  end
  
  context 'when playing the game' do
    let(:board) { Board.new}

    it 'can place a nought ' do
      board.place(:nought, {x: 0, y: 0})
      expect(board.grid[0][0]).to eq 1
    end

    it 'can place a cross on the last square' do
      board.place(:cross, {x: 2, y: 2})
      expect(board.grid[2][2]).to eq -1
    end

    it 'cannot place a marker on a non-empty square' do
      board.place(:nought, {x: 0, y: 0})
      expect{board.place_if_valid(:cross, {x: 0, y: 0})}.to raise_error('that space is taken!')
      expect(board.grid[0][0]).to eq 1
    end


  end
end