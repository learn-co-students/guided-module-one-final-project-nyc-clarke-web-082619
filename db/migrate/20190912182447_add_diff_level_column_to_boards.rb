class AddDiffLevelColumnToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :difficulty, :string
  end
end
