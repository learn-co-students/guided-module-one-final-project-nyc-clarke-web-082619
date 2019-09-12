require 'bundler'
require "rubygems"
require "tty-prompt"
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all '../lib/app/models/deck'
require_all '../lib/app/models/user'
