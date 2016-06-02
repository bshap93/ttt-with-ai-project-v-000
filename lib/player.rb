require 'pry'
class Player

  attr_reader :token, :game

  def initialize(token, num_players)
    token == "X" || token == "O" ? @token = token : raise("Must select X or O")
    case num_players
    when "0"
      self.game = Game.new(Player::Computer.new("X", "0"), Player::Computer.new("O", "0"), Board.new)
    when "1"
      self.game = Game.new(Player::Human.new("X", "1"), Player::Computer.new("O", "1"), Board.new)
    when "2"
      self.game = Game.new(Player::Human.new("X", "2"), Player::Human.new("O", "2"), Board.new)
    end
  end

end