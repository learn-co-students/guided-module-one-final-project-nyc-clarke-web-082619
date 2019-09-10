class CreatePickupLines < ActiveRecord::Migration[5.0]
  def change
    create_table :pickup_lines do |t|
      t.string :content  
      t.integer :provider_id
      t.integer :user_id #keep track of lines that worked?
      t.integer :location_id
    end
  end
end
