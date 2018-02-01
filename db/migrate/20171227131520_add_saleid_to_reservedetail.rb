class AddSaleidToReservedetail < ActiveRecord::Migration[5.1]
  def change
    add_column :reservedetails, :sale_id, :integer
  end
end
