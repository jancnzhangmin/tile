class AddCooperidToCooperdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :cooperdetails, :cooper_id, :integer
  end
end
