require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  Pry.start
end

desc 'starts the app'
task :start do
  system 'ruby bin/run.rb'
end
