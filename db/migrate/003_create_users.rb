class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.string :account_type  #get rid of this
      t.boolean :active_user #you can cancel 
      t.integer :provider_id
      t.integer :location_id
      t.string :accepted_lines #lines that worked/ check against pickupline 
      t.string :rejected_lines  #get rid of this
    end
  end
end
