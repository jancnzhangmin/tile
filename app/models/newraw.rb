class Newraw < ApplicationRecord
  has_many :newrawspecs
  has_many :newworkdetails
end
