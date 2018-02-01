class AddCostToNewrawspec < ActiveRecord::Migration[5.1]
  def change
    add_column :newrawspecs, :cost, :float
  end
end
