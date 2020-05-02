class TicTacToe
  SYMBOLS = {player0: ' ',
             player1: 'X',
             player2: 'O'}

  def initialize(name1, name2)
    @grid = [Array.new(3, SYMBOLS[:player0]),
             Array.new(3, SYMBOLS[:player0]),
             Array.new(3, SYMBOLS[:player0])]
    @player_names = {player1: name1,
                     player2: name2}
  end

  def play
    self.display
    player = :player2
    begin
      player = self.switch_player(player)
      self.play_round(player)
    end until self.win? || self.tie?
    puts (self.tie?) ? self.display_tie : self.display_winner(player)
  end

  private

  def empty?(row, col)
    @grid[row][col] == SYMBOLS[:player0]
  end

  def switch_player(player)
    (player == :player1) ? :player2 : :player1
  end

  def line_separator
    '+' * 13
  end

  def display_winner(player)
    "Congratulations #{@player_names[player]}! You Won"
  end

  def display_tie
    "It's a tie ! You should have a rematch"
  end

  def display
    puts self.line_separator
    @grid.each do |line|
      line.each {|char| print "| #{char} "}
      puts "|"
      puts self.line_separator
    end
  end

  def get_position
    begin
      begin
        puts "Which row do you want to play in ?"
        row = gets.chomp.to_i - 1
      end until 0 <= row && row <3
      begin
        puts "Which column do you want to play in ?"
        col = gets.chomp.to_i - 1
      end until 0 <= col && col < 3
    end until self.empty?(row, col)
    [row, col]
  end

  def play_position(player, coord)
    @grid[coord[0]][coord[1]] = SYMBOLS[player]
  end

  def play_round(player)
    self.play_position(player, self.get_position)
    self.display
  end

  def row_win?
    3.times do |i|
      unless @grid[i][1] == SYMBOLS[:player0]
        return true if @grid[i][0] == @grid[i][1] && @grid[i][1] == @grid[i][2]
      end
    end
    false
  end

  def column_win?
    3.times do |i|
      unless @grid[1][i] == SYMBOLS[:player0]
        return true if @grid[0][i] == @grid[1][i] && @grid[1][i] == @grid[2][i]
      end
    end
    false
  end

  def diagonal_win?
    unless @grid[1][1] == SYMBOLS[:player0]
      return true if @grid[0][0] == @grid[1][1] && @grid[1][1] == @grid[2][2]
      return true if @grid[2][0] == @grid[1][1] && @grid[1][i] == @grid[0][2]
    end
    false
  end
  
  def win?
    self.row_win? || self.column_win? || self.diagonal_win?
  end

  def tie?
    @grid.flatten.none? {|char| char == SYMBOLS[:player0]}
  end
end

game = TicTacToe.new("Maxime", "Opponent")
game.play