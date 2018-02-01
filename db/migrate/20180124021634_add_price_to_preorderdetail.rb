class AddPriceToPreorderdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :preorderdetails, :price, :float
  end
end
