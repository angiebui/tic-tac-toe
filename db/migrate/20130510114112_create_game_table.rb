class CreateGameTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_one
      t.integer :player_two
      t.string :outcome
      t.timestamps
    end
  end
end
