class Reservedetail < ApplicationRecord
  belongs_to :reserve
  belongs_to :sale
end
