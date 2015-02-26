require 'board'

describe Board do

  context 'when created' do

    let(:board) { Board.new }

    it 'has a grid' do
      expect(board.grid).to be_instance_of(Array)
    end


    it 'with three rows' do
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

  context 'determining line scores' do 
    
    let(:board) { Board.new }
    before { 
      board.grid[0][0] = 1
      board.grid[1][1] = -1
      board.grid[0][1] = 1
    }

    it 'knows the row scores' do
      expect(board.row_scores).to eq [2,-1,0]
    end

    it 'knows the column scores' do
      expect(board.column_scores).to eq [1,0,0]
    end

    it 'knows the diagonal scores' do
      expect(board.diag_scores).to eq [0,-1]
    end

    it 'knows the line scores' do
      expect(board.line_scores).to eq [2,-1,0,1,0,0,0,-1]
    end

  end


end