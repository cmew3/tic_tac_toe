class Game

  attr_reader :players, :turn_count, :board, :winner

  def initialize player1, player2
    @board=Board.new
    @players=[player1,player2]
    @turn_count = 0

  end

  def place(player, coordinates)
    board.grid[coordinates[:x]][coordinates[:y]]=player.symbol_to_i
    @turn_count += 1
  end

  def place_if_valid(player, coordinates)
    if board.grid[coordinates[:x]][coordinates[:y]]==0 
      place(player,coordinates)
      return true
    else
      puts 'that space is taken!'
      return false
    end
  end

# this needs refactoring
  def winner 
    if Board.line_scores(board.grid).include?(3)
      return players.select {|player| player.symbol == :nought}[0]
    elsif Board.line_scores(board.grid).include?(-3)
      return players.select {|player| player.symbol == :cross}[0]
    end
  end

  # these functions are not tested as they are used for playing in terminal

  def print_to_terminal
    grid.each do |row|
      row.each do |element|
        print "O " if(element==1)
        print "X " if(element==-1)
        print "- " if(element==0)
      end
      print "\n"
    end
  end

  def play_next_turn 
    if turn_count % 2 == 0
      play_turn(players[0])
    else
      play_turn(players[1])
    end
  end

  def play_turn(player)
    marker_placed=false
    until marker_placed
      coordinates = player.select_coordinate(board)
      marker_placed = place_if_valid(player, coordinates)
    end
  end

  def play_game 
    until winner 
      play_next_turn
    end
  end

end