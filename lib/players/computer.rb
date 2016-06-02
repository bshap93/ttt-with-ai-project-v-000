require './config/environment.rb'
class Computer < Player


  def move(board)
    valid = false
    until valid != false
      position = NewGame.new_game.choice
      valid = board.valid_move?(position)
    end
    position.to_s
  end

end