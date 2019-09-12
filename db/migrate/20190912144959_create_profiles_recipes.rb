class CreateProfilesRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles_recipes do |t|
      t.integer :profile_id
      t.integer :recipe_id
    end 
  end
end
