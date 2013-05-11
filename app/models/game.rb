class Game < ActiveRecord::Base
  WINNING_COMBOS = [ ["A1", "A2", "A3"],
                     ["B1", "B2", "B3"],
                     ["C1", "C2", "C3"],
                     ["A1", "B1", "C1"],
                     ["A2", "B2", "C2"],
                     ["A3", "B3", "C3"],
                     ["A1", "B2", "C3"],
                     ["A3", "B2", "C1"] ]
  has_many :moves
  belongs_to :player_one, :class_name => "Player", :foreign_key => "player_one"
  belongs_to :player_two, :class_name => "Player", :foreign_key => "player_two"

  def winner
    player_one_moves = self.player_one.moves(self.id) # Define moves on player
    player_two_moves = self.player_two.moves(self.id) # Define moves on player
    WINNING_COMBOS.each do |combo|
      return player_one if combo.all? { |coord| player_one_moves.include? coord }
      return player_two if combo.all? { |coord| player_two_moves.include? coord }
    end
    nil
  end

  def player(player_id)
    return "player_one" if player_id == self.player_one.id
    return "player_two" if player_id == self.player_two.id
    "code should never reach this point"
  end

  def draw?
    self.moves.length == 9
  end
end

