class Board

  attr_reader :players, :turn_count, :grid, :winner

  def initialize player1, player2
    @grid=[[0,0,0],[0,0,0],[0,0,0]]
    @players=[player1,player2]
    @turn_count = 0

  end

  def place(player, coordinates)
    marker = player.symbol
    case marker
    when :nought
      grid[coordinates[:x]][coordinates[:y]]=1
    when :cross 
      grid[coordinates[:x]][coordinates[:y]] = -1
    end
    @turn_count += 1
  end

  def place_if_valid(player, coordinates)
    if grid[coordinates[:x]][coordinates[:y]]==0 
      place(player,coordinates)
      return true
    else
      puts 'that space is taken!'
      return false
    end
  end

  def row_scores 
    grid.map { |row| row.inject(:+) }
  end

  def column_scores 
    grid.transpose.map { |row| row.inject(:+) }
  end

  def diag_scores 
    diag1, diag2 = 0, 0
    for i in 0..2
      diag1+=grid[i][i]
      diag2+=grid[i][2-i]
    end
    [diag1,diag2]
  end

  def line_scores 
    row_scores + column_scores + diag_scores
  end

  def winner 
    if line_scores.include?(3)
      return players.select {|player| player.symbol == :nought}[0]
    elsif line_scores.include?(-3)
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
      print_to_terminal
      coordinates = player.select_coordinate
      marker_placed = place_if_valid(player, coordinates)
    end
  end

  def play_game 
    until winner 
      play_next_turn
    end
  end

end