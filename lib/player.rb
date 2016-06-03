require 'pry'
require './config/environment.rb'
class Player

  attr_reader :token, :game
  def initialize(token, num_players)
    token == "X" || token == "O" ? @token = token : raise("Must select X or O")
    @game = NewGame.which_game(num_players)
  end

end