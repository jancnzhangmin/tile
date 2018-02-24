class AddPriceToPreraw < ActiveRecord::Migration[5.1]
  def change
    add_column :preraws, :price, :float
  end
end
