class CreateProfilesIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles_ingredients do |t|
      t.integer :profile_id
      t.integer :ingredient_id
    end 
  end
end
