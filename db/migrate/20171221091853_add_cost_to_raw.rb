class AddCostToRaw < ActiveRecord::Migration[5.1]
  def change
    add_column :raws, :cost, :float
  end
end
