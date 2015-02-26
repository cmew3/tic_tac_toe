require 'game'
require 'player'
require 'board'

describe Game do

  context 'before the game starts' do
    let(:player1)  { Player.new("Sarah", :nought) }
    let(:player2)  { Player.new("Anna", :cross)   }
    let(:game)     { Game.new(player1,player2)    }

    it 'has a board' do
      expect(game.board).to be_instance_of(Board)
    end

    it 'has two players' do
      expect(game.players.count).to eq 2
    end

    it 'has a zero turn count' do
      expect(game.turn_count).to eq 0
    end

  end
  
  context 'when playing the game' do
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:game) { Game.new(player1, player2) }

    it 'can place a nought for player 1' do
      game.place(player1, {x: 0, y: 0})
      expect(game.board.grid[0][0]).to eq 1
      expect(game.board.grid.flatten.inject(:+)).to eq 1
    end

    it 'can place a cross for player2' do
      game.place(player2, {x: 2, y: 2})
      expect(game.board.grid[2][2]).to eq -1
    end

    it 'cannot place a marker on a non-empty square' do
      game.place_if_valid(player1, {x: 0, y: 0})
      expect(STDOUT).to receive(:puts).with('that space is taken!')
      game.place_if_valid(player2, {x: 0, y: 0})
    end

  end

  context 'when counting turns' do

    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:game) { Game.new(player1, player2) }

    it 'counts how many turns have been taken' do
      game.place_if_valid(player1, {x: 0, y: 0})
      game.place_if_valid(player1, {x: 1, y: 1})
      expect(game.turn_count).to eq 2
     end

     it 'does not count a turn if placement is not valid' do
      allow(STDOUT).to receive(:puts)
      game.place_if_valid(player1, {x: 0, y: 0})
      game.place_if_valid(player1, {x: 0, y: 0})
      expect(game.turn_count).to eq 1
     end

     it 'completes a player\'s turn when a valid placement is found' do
      game.place_if_valid(player1, {x: 0, y: 0})
      allow(player2).to receive(:select_coordinate).with(game.board).and_return({ x:0, y:0 },{x:1,y:1})
      game.play_turn(player2)
      expect(game.turn_count).to eq 2
     end

     it 'prompts the second player\'s turn' do
      game.place_if_valid(player1, {x: 0, y: 0})
      allow(player2).to receive(:select_coordinate).with(game.board).and_return({ x:0, y:2 })
      game.play_next_turn
      expect(game.board.grid.flatten.inject(:+)).to eq 0
  
     end

     it 'prompts the first player\'s turn ' do
      game.place_if_valid(player1, {x: 0, y: 0})
      game.place_if_valid(player2, {x: 0, y: 1})
      allow(player1).to receive(:select_coordinate).with(game.board).and_return({ x:0, y:2 })
      game.play_next_turn
      expect(game.board.grid.flatten.inject(:+)).to eq 1
     end

  end

  context 'determining a winner' do 
    
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:game) { Game.new(player1, player2) }
    before { 
      game.place_if_valid(player1, {x: 0, y: 0})
      game.place_if_valid(player2, {x: 1, y: 1})
      game.place_if_valid(player1, {x: 0, y: 1})
    }

    it 'knows that player 1 has won' do
      game.place_if_valid(player2, {x: 1, y: 0})
      game.place_if_valid(player1, {x: 0, y: 2})
      expect(game.winner).to eq player1
    end

    it ' knows when there is no winner' do
      expect(game.winner).to eq nil
    end

  end

  context 'playing a game' do
    player1 = Player.new("Sarah", :nought)
    player2 = Player.new("Anna", :cross)
    let(:game) { Game.new(player1, player2) }

    it 'takes turns until there is a winner' do
      expect(game).to receive(:winner).and_return(nil,nil, nil, player1)
      expect(game).to receive(:play_next_turn).exactly(3).times
      game.play_game
    end

  end



end