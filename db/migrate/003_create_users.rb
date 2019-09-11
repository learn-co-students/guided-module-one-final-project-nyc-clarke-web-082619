class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.boolean :active_user 
      t.integer :provider_id
      t.integer :location_id
      t.string :accepted_lines 
    end
  end
end
