class AddCooperToPreorderdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :preorderdetails, :cooper_id, :integer
    add_column :preorderdetails, :cooperuser_id, :integer
  end
end
