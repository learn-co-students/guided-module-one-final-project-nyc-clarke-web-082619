class User < ActiveRecord::Base
  has_many :pickup_lines
  has_many :providers
  has_many :locations


end

#request for service
#accept the offer, or reject
#fire someone
#cancel service



#upgrade to premium

