class AddColumnToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :puzzle, :string
  end
end
