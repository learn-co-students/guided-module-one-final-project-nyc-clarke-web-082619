class CreatePickupLines < ActiveRecord::Migration[5.0]
  def change
    create_table :pickup_lines do |t|
      t.string :location
      t.string :content  #should pass in a random sample from the correct file
      t.integer :provider_id
      t.integer :user_id
    end
  end
end
