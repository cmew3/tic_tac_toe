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

    it 'has a zero turn count' do
      expect(board.turn_count).to eq 0
    end


  end
  
  context 'when playing the game' do
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:board) { Board.new(player1, player2) }

    it 'can place a nought for player 1' do
      board.place(player1, {x: 0, y: 0})
      expect(board.grid[0][0]).to eq 1
      expect(board.grid.flatten.inject(:+)).to eq 1
    end

    it 'can place a cross for player2' do
      board.place(player2, {x: 2, y: 2})
      expect(board.grid[2][2]).to eq -1
    end

    it 'cannot place a marker on a non-empty square' do
      board.place_if_valid(player1, {x: 0, y: 0})
      expect(STDOUT).to receive(:puts).with('that space is taken!')
      board.place_if_valid(player2, {x: 0, y: 0})
    end

  end

  context 'when counting turns' do

    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:board) { Board.new(player1, player2) }

    it 'counts how many turns have been taken' do
      board.place_if_valid(player1, {x: 0, y: 0})
      board.place_if_valid(player1, {x: 1, y: 1})
      expect(board.turn_count).to eq 2
     end

     it 'does not count a turn if placement is not valid' do
      allow(STDOUT).to receive(:puts)
      board.place_if_valid(player1, {x: 0, y: 0})
      board.place_if_valid(player1, {x: 0, y: 0})
      expect(board.turn_count).to eq 1
     end

     it 'completes a player\'s turn when a valid placement is found' do
      board.place_if_valid(player1, {x: 0, y: 0})
      allow(player2).to receive(:select_coordinate).and_return({ x:0, y:0 },{x:1,y:1})
      board.play_turn(player2)
      expect(board.turn_count).to eq 2
     end

     it 'prompts the second player\'s turn' do
      board.place_if_valid(player1, {x: 0, y: 0})
      allow(player2).to receive(:select_coordinate).and_return({ x:0, y:2 })
      board.play_next_turn
      expect(board.grid.flatten.inject(:+)).to eq 0
  
     end

     it 'prompts the first player\'s turn ' do
      board.place_if_valid(player1, {x: 0, y: 0})
      board.place_if_valid(player2, {x: 0, y: 1})
      allow(player1).to receive(:select_coordinate).and_return({ x:0, y:2 })
      board.play_next_turn
      expect(board.grid.flatten.inject(:+)).to eq 1
     end

  end

  context 'determining a winner' do 
    
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:board) { Board.new(player1, player2) }
    before { 
      board.place_if_valid(player1, {x: 0, y: 0})
      board.place_if_valid(player2, {x: 1, y: 1})
      board.place_if_valid(player1, {x: 0, y: 1})
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

    it 'knows that player 1 has won' do
      board.place_if_valid(player2, {x: 1, y: 0})
      board.place_if_valid(player1, {x: 0, y: 2})
      expect(board.winner).to eq player1
    end

    it ' knows when there is no winner' do
      expect(board.winner).to eq nil
    end

  end

  context 'playing a game' do
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:board) { Board.new(player1, player2) }

    it 'takes turns until there is a winner' do
      expect(board).to receive(:winner).and_return(nil,nil, nil, player1)
      expect(board).to receive(:play_next_turn).exactly(3).times
      board.play_game
    end

  end



end