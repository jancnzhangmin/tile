class AddCostToPreraw < ActiveRecord::Migration[5.1]
  def change
    add_column :preraws, :cost, :float
  end
end
