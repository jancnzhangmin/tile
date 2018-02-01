class AddUnitToPreorderdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :preorderdetails, :unit, :string
  end
end
