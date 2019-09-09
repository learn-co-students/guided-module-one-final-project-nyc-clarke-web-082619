class Provider < ActiveRecord::Base
  has_many :pickup_lines
  has_many :users
end