
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../config/environment'



doc = Nokogiri::HTML.parse(open('https://www.epicurious.com/search?content=recipe&page=1'))
#doc.css('h4 a').first.attribute('href').value


how_many_pages = 20
start_page = 81
end_page = start_page + how_many_pages
page_counter = 0



# -------------------- Grab Names of Epicurious Recipes from how_many_pages -------------
recipe_url_array = []


while (start_page + page_counter) <  end_page do
    search_page = Nokogiri::HTML.parse(open('https://www.epicurious.com/search?content=recipe&page=' + (start_page + page_counter).to_s))
    title_array = search_page.css('h4').collect do |recipe_title_object|
        recipe_title_object.css('a').attribute('href').value if recipe_title_object.css('a').attribute('href') 

    end
    recipe_url_array.concat(title_array)
    recipe_url_array.delete("")
    recipe_url_array.compact!
    page_counter += 1
    # if page_counter % 20 == 0
    #     puts "Getting Page #{page_counter}"
    # end
end



# ------------------ Grab Content from individual Recipe Page -----------------

page_counter_2 = 0
recipe_class_array = []

while page_counter_2 < recipe_url_array.length do
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
    
    #Saves the new recipe to the database
    new_recipe.save


    # end
    # recipe_url_array.concat(title_array)
    # recipe_url_array.delete("")
    # recipe_url_array.compact!

    page_counter_2 += 1

    if page_counter_2 % 50 == 0
        puts "Getting recipe number #{page_counter_2}"
    end
end

#  recipe_class_array.each {|recipe| recipe.save}



