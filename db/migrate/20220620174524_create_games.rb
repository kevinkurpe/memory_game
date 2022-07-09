class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.json :game_board
      t.integer :score
      t.string :time
      t.integer :points_recall
      t.integer :points_blind
      t.integer :turns

      t.timestamps
    end
  end
end
