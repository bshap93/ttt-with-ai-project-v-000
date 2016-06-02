class Computer < Player

  def move(board)
    valid = false
    until valid != false
      binding.pry
      position = $game.choice
      valid = board.valid_move?(position)
    end
    position.to_s
  end

end