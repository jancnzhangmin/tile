class Good < ApplicationRecord

  has_many :ingooddepotdetails
  has_many :gooddepots
has_many :borrowdetails
  has_many :returngooddetails

end
