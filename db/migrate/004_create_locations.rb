class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name   #comes from a preset list
      t.integer :pickup_line_id
      t.integer :user_id
    end
  end
end
