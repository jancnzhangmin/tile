class AddPrerawidToPreorderdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :preorderdetails, :preraw_id, :integer
  end
end
