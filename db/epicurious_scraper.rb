
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../config/environment'



doc = Nokogiri::HTML.parse(open('https://www.epicurious.com/search?content=recipe&page=1'))
#doc.css('h4 a').first.attribute('href').value

page_counter = 1



# -------------------- Grab Names of Epicurious Recipes from how_many_pages -------------
recipe_url_array = []
how_many_pages = 5

while page_counter <= how_many_pages do
    search_page = Nokogiri::HTML.parse(open('https://www.epicurious.com/search?content=recipe&page=' + page_counter.to_s))
    title_array = search_page.css('h4').collect do |recipe_title_object|
        recipe_title_object.css('a').attribute('href').value if recipe_title_object.css('a').attribute('href') 

    end
    recipe_url_array.concat(title_array)
    recipe_url_array.delete("")
    recipe_url_array.compact!
    page_counter += 1
end



# ------------------ Grab Content from individual Recipe Page -----------------

page_counter_2 = 0
recipe_class_array = []

while page_counter_2 < 20 do
    recipe_url = 'https://www.epicurious.com' + recipe_url_array[page_counter_2]
    recipe_page = Nokogiri::HTML.parse(open(recipe_url))


    # Grab name of this recipe and save it to new Recipe instance
    #recipe_page.css('ul.ingredients li.ingredient').text
    name_of_recipe = recipe_page.css('h1').text
    name_of_recipe.chomp!
    new_recipe = Recipe.new(name: name_of_recipe)

    #This is where we are grabbing ingredients from the recipe page 
    ingredients_text = recipe_page.css('ul.ingredients').collect do |recipe_ingredients_list|
        recipe_ingredients_list.css('li.ingredient').collect do |ingredient| 
            ingredient.text
        end
    end.flatten

    new_recipe.ingredient_list = ingredients_text

    #This is where we are getting the preparation context and shoveling into an array 
    preparation_text = recipe_page.css('li.preparation-step').collect do |preparation_paragraph|
        preparation_paragraph.text.strip
        end.flatten

    new_recipe.content = preparation_text
    
    #Shovels name, ingredient list and content in recipe class array
    recipe_class_array << new_recipe


    # end
    # recipe_url_array.concat(title_array)
    # recipe_url_array.delete("")
    # recipe_url_array.compact!
    page_counter_2 += 1
end

recipe_class_array.each {|recipe| recipe.save}

binding.pry

