class AddUserheightToPreorderdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :preorderdetails, :userheight, :float
  end
end
