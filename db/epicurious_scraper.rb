
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

while page_counter_2 < 5 do
    recipe_url = 'https://www.epicurious.com' + recipe_url_array[page_counter_2]
    recipe_page = Nokogiri::HTML.parse(open(recipe_url))

    name_of_recipe = recipe_page.css('h1').text
    name_of_recipe.chomp!

    new_recipe = Recipe.new(name: name_of_recipe)
    binding.pry
    # recipe_page.css('h4').collect do |recipe_title_object|
    #     recipe_title_object.css('a').attribute('href').value if recipe_title_object.css('a').attribute('href') 

    # end
    # recipe_url_array.concat(title_array)
    # recipe_url_array.delete("")
    # recipe_url_array.compact!
    page_counter_2 += 1
end


