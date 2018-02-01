class Sale < ApplicationRecord
  has_many :saledepots
  has_many :insaledepotdetails
  has_many :reservedetails
  has_many :saleredetails
  has_many :saledetails
end
