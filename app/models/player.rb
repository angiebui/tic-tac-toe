class Player < ActiveRecord::Base
  # Remember to create a migration!

  def moves(game_id)
    Move.where('game_id = ? and player_id = ?', game_id, self.id).map{ |move| move.coord }
  end
end
