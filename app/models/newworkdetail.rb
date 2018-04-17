class Newworkdetail < ApplicationRecord
  belongs_to :newwork
  belongs_to :newraw
  has_many :shapes
end
