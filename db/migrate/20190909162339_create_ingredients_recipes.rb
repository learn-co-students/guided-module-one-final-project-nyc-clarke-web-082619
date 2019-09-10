class CreateIngredientsRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients_recipes do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
    end
  end
end
