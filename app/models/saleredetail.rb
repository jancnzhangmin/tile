class Saleredetail < ApplicationRecord
  belongs_to :salere
  belongs_to :sale
  belongs_to :raw
end
