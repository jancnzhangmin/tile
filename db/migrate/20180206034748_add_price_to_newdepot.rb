class AddPriceToNewdepot < ActiveRecord::Migration[5.1]
  def change
    add_column :newdepots, :price, :float
    add_column :newdepots, :number, :float
  end
end
