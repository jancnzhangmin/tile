class Supplier < ApplicationRecord
  has_many :inrawdepots
  has_many :supplierpayments
end
