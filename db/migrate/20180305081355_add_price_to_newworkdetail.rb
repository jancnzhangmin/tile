class AddPriceToNewworkdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :newworkdetails, :price, :float
  end
end
