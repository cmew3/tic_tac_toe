require 'board'
require 'player'

describe Board do

  context 'before the game starts' do
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:board) { Board.new(player1,player2)}

    context 'has a grid' do

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

    it 'has two players' do
      expect(board.players.count).to eq 2
    end


  end
  
  context 'when playing the game' do
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:board) { Board.new(player1, player2) }

    it 'can place a nought for player 1' do
      board.place(player1, {x: 0, y: 0})
      expect(board.grid[0][0]).to eq 1
    end

    it 'can place a cross for player2' do
      board.place(player2, {x: 2, y: 2})
      expect(board.grid[2][2]).to eq -1
    end

    it 'cannot place a marker on a non-empty square' do
      board.place(player1, {x: 0, y: 0})
      expect{board.place_if_valid(player2, {x: 0, y: 0})}.to raise_error('that space is taken!')
      expect(board.grid[0][0]).to eq 1
    end

  end

  context 'when counting goes' do

    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:board) { Board.new(player1, player2) }

    xit 'counts how many turns have been taken' do
      board.place_if_valid(player2, {x: 0, y: 0})
      board.place_if_valid(player2, {x: 1, y: 1})
     end

  end



end