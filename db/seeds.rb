
Ingredient.destroy_all
Recipe.destroy_all
IngredientsRecipe.destroy_all
##### INGREDIENTS ######

ing1 = Ingredient.create(name: 'Milk')
ing2 = Ingredient.create(name: 'Beef')
ing3 = Ingredient.create(name: 'Tortilla')
ing4 = Ingredient.create(name: 'Broccoli')
ing5 = Ingredient.create(name: 'Egg')
ing6 = Ingredient.create(name: 'Chicken')
ing7 = Ingredient.create(name: 'Carrot')
ing8 = Ingredient.create(name: 'Rice')
ing9 = Ingredient.create(name: 'Cheese')
ing10 = Ingredient.create(name: 'Beans')
ing11 = Ingredient.create(name: 'Pineapple')
ing12 = Ingredient.create(name: 'Flour')

##### RECIPES ######

rec1 = Recipe.create(name: 'Chicken Casserole', content: 'Make it 1')
rec2 = Recipe.create(name: 'Steak and Eggs', content: 'Make it 2')
rec3 = Recipe.create(name: 'Chicken and Broccoli', content: 'Make it 3')
rec4 = Recipe.create(name: 'Beef and Broccoli', content: 'Make it 4')
rec5 = Recipe.create(name: 'Burrito', content: 'Make it 5')
rec6 = Recipe.create(name: 'Pizza', content: 'Make it 6')
rec7 = Recipe.create(name: 'Carrot Cake', content: 'Make it 7')


####### INGREDIENT_RECIPES ########
rec1.ingredients << ing6
rec1.ingredients << ing8
rec1.ingredients << ing4
rec1.ingredients << ing7
rec2.ingredients << ing2
rec2.ingredients << ing5
rec3.ingredients << ing6
rec3.ingredients << ing4
rec4.ingredients << ing2
rec4.ingredients << ing4
rec5.ingredients << ing2
rec5.ingredients << ing3
rec5.ingredients << ing8
rec5.ingredients << ing9
rec5.ingredients << ing10
rec6.ingredients << ing9
rec6.ingredients << ing12
rec7.ingredients << ing1
rec7.ingredients << ing5
rec7.ingredients << ing7
rec7.ingredients << ing12