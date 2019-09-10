class Location < ActiveRecord::Base
  has_many :pickup_lines
  belongs_to :user

end