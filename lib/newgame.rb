require './config/environment.rb'
class NewGame
  attr_reader :game
  def self.which_game(num_players)
    if num_players == "0"
      @game = Game.new(Player::Computer.new("X", "0"), Player::Computer.new("O", "0"), Board.new)
    elsif num_players == "1"
      @game = Game.new(Player::Human.new("X", "1"), Player::Computer.new("O", "1"), Board.new)
    elsif num_players == "2"
      @game = Game.new(Player::Human.new("X", "2"), Player::Human.new("O", "2"), Board.new)
    else
      puts "Put 0,1 or 2"
    end
  end
end