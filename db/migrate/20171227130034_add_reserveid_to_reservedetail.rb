class AddReserveidToReservedetail < ActiveRecord::Migration[5.1]
  def change
    add_column :reservedetails, :reserve_id, :integer
  end
end
