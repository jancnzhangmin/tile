class AddNumberToPreorderdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :preorderdetails, :number, :float
  end
end
