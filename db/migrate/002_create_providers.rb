class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.boolean :employed  #should default to true until user selects for them to get fired
    end
      
  end
end
