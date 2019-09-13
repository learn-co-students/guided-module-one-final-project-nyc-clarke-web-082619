class User < ActiveRecord::Base
  has_many :pickup_lines
  belongs_to :provider
  has_many :locations 
end

