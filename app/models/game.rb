class Game < ActiveRecord::Base
  has_many :moves
  belongs_to :player_one, :class_name => "Player", :foreign_key => "player_one"
  belongs_to :player_two, :class_name => "Player", :foreign_key => "player_two"
end
