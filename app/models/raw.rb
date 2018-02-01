class Raw < ApplicationRecord
  has_many :inrawdepotdetails
  has_many :rawdepots
  has_many :inrawdepots
  has_many :inworkdepotdetails

  has_many :saledetails
end
