class AddSumToReservedetail < ActiveRecord::Migration[5.1]
  def change
    add_column :reservedetails, :sum, :float
  end
end
