require './config/environment.rb'
require 'pry'
class Game
  attr_accessor :board, :player_1, :player_2, :winner
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

  def initialize(player_1=Player::Human.new("X"), player_2=Player::Human.new("O"), board=Board.new)
    @player_1 = player_1; @player_2 = player_2; @board = board
  end

  def current_player
    self.board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?(player)
    WIN_COMBINATIONS.detect do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = self.board.cells[win_index_1]
      position_2 = self.board.cells[win_index_2]
      position_3 = self.board.cells[win_index_3]
   
      if (position_1 == "X" && position_2 == "X" && position_3 == "X") && player == (self.player_1 || nil)
        @winner = @player_1
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O") && player == (self.player_2 || nil)
        @winner = @player_2
      end
    end
    @winner
  end

  def full?
    if self.board.cells.all?{|i| (i == "X") || (i == "O")}
      true
    else 
      false
    end
  end

  def draw?
    if !(won?(self.player_1) || won?(self.player_2)) && full?
      true
    else
      false
    end
  end

  def over?
    if (won?(self.player_1) || won?(self.player_2)) || draw? || full?
      true
    else 
      false
    end
  end

  def winner
    (won?(self.player_1) || won?(self.player_2))
  end

  def turn
    puts "Please enter 1-9:"
    position = self.current_player.move(self.board.cells)
    if !self.board.valid_move?(position)
      turn
    else
      self.board.update(position.to_i, current_player)
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cats Game!"
    end
  end


  def score
    if self.won?(self.player_1)
      return 10
    elsif self.won?(self.player_2)
      return 10
    else
      return 0
    end
  end

  def get_available_moves
    (0..8).select { |i| self.board.cells[i] == " "}.collect{|i| (i + 1).to_s}
  end
  
  def minimax
    return score if self.over?
    scores = [] # an array of scores
    moves = []  # an array of moves

    # Populate the scores array, recursing as needed
    self.get_available_moves.each do |position|
      possible_game = self.dup
      possible_move = possible_game.board.update(position, self.player_1)
      scores << possible_game.minimax
      moves << position
    end

    # Do the min or the max calculation
    if self.current_player == self.player_1
      # This is the max calculation
      max_score_index = scores.each_with_index.max[1]
      @choice = moves[max_score_index]
      return scores[max_score_index]
    else
      # This is the min calculation
      min_score_index = scores.each_with_index.min[1]
      @choice = moves[min_score_index]
      return scores[min_score_index]
    end
  end

  def evaluate_state
    if self.won?(piece)
      @base_score
    elsif game_state.lost?(piece)
      depth - @base_score
    else
      0
    end
  end

  def best_possible_move
    @base_score = self.get_available_moves.count + 1
    bound = @base_score + 1
    minmax
  end



end
game = Game.new
game.board.cells = [' ', 'O', ' ', ' ', ' ', 'O', 'X', 'X', 'O']
binding.pry