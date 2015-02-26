require 'board'

describe Board do

  context 'when created' do

    let(:board)   { Board.new   }

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
    
    let(:board)   { Board.new   }
    let(:square_array) { [[1,1,0],[0,-1,0],[0,0,0]]}

    it 'knows the row scores' do
      expect(Board.row_scores(square_array)).to eq [2,-1,0]
    end

    it 'knows the column scores' do
      expect(Board.column_scores(square_array)).to eq [1,0,0]
    end

    it 'knows the diagonal scores' do
      expect(Board.diag_scores(square_array)).to eq [0,-1]
    end

    it 'knows the line scores' do
      expect(Board.line_scores(square_array)).to eq [2,-1,0,1,0,0,0,-1]
    end

  end

  context 'determining choice values' do 
    let(:board)   { Board.new   }
    before  { 
              board.grid[0][0] = 1
              board.grid[1][1] = -1
              board.grid[0][1] = 1
              board.grid[1][0] = -1
            }
    it 'can tell if nought\'s play move is a winning play' do
      expect(board.is_winning_play?(1, {x: 0, y: 2})).to be true
    end

    it 'can tell if nought\'s play is not a winning play' do
       expect(board.is_winning_play?(1, {x: 2, y: 2})).to be false
    end

    it 'can tell if cross\'s play move is a winning play' do
      expect(board.is_winning_play?(-1, {x: 1, y: 2})).to be true
    end

  end

end