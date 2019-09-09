class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.string :account_type  #should default to 'generic'
      t.boolean :active_user #should default to active upon creation'
      t.integer :provider_id
      t.integer :location_id
      t.string :accepted_lines #should be shovelled into an array as they are accepted
      t.string :rejected_lines  #same as above
    end
  end
end
