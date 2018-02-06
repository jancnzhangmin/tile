class AddRawtypeToPreorderdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :preorderdetails, :rawtype, :string
  end
end
