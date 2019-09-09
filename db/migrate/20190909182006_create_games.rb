class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.time :start_time #initialize
      t.time :end_time #set upon winning
      t.float :total_time #difference
    end
  end
end
