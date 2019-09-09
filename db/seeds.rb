
Ingredient.destroy_all
Recipe.destroy_all
IngredientsRecipe.destroy_all
##### INGREDIENTS ######

ing1 = Ingredient.create(name: 'Milk', category: 'Dairy')
ing2 = Ingredient.create(name: 'Beef', category: 'Meat')
ing3 = Ingredient.create(name: 'Tortilla', category: 'Grain')
ing4 = Ingredient.create(name: 'Broccoli', category: 'Vegetable')
ing5 = Ingredient.create(name: 'Egg', category: 'Egg')
ing6 = Ingredient.create(name: 'Chicken', category: 'Meat')
ing7 = Ingredient.create(name: 'Carrot', category: 'Vegetable')
ing8 = Ingredient.create(name: 'Rice', category: 'Grain')
ing9 = Ingredient.create(name: 'Cheese', category: 'Dairy')
ing10 = Ingredient.create(name: 'Beans', category: 'Legume')
ing11 = Ingredient.create(name: 'Pineapple', category: 'Fruit')
ing12 = Ingredient.create(name: 'Flour', category: 'Grain')

##### RECIPES ######

rec1 = Recipe.create(name: 'Chicken Casserole', cuisine: 'American', content: 'Make it 1')
rec2 = Recipe.create(name: 'Steak and Eggs', cuisine: 'American', content: 'Make it 2')
rec3 = Recipe.create(name: 'Chicken and Broccoli', cuisine: 'Chinese', content: 'Make it 3')
rec4 = Recipe.create(name: 'Beef and Broccoli', cuisine: 'Chinese', content: 'Make it 4')
rec5 = Recipe.create(name: 'Burrito', cuisine: 'Mexican', content: 'Make it 5')
rec6 = Recipe.create(name: 'Pizza', cuisine: 'Italian', content: 'Make it 6')
rec7 = Recipe.create(name: 'Carrot Cake', cuisine: 'French', content: 'Make it 7')


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