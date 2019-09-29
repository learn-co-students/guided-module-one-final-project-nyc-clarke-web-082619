
require 'nokogiri'
require 'open-uri'
require_relative '../config/environment'
require 'pry'


ingredient_name_array = File.open(Dir.getwd + "/db/ingredient_text_file.txt").map do |item| 
    item.singularize.downcase.strip
end

ingredient_class_array = ingredient_name_array.map do |ingredient_name|
    Ingredient.create(name: ingredient_name)
end

#ingredient_class_array.each {|ingredient|  ingredient.save}