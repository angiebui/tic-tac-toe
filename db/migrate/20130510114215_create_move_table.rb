class CreateMoveTable < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :player_id
      t.integer :game_id
      t.string :coord
    end
  end
end
