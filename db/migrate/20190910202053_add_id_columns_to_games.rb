class AddIdColumnsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :board_id, :integer
    add_column :games, :player_id, :integer
  end
end
