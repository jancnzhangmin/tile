class AddCostToNewworkdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :newworkdetails, :cost, :float
    add_column :newworkdetails, :prict, :float
  end
end
