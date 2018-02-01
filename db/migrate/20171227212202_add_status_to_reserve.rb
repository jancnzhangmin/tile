class AddStatusToReserve < ActiveRecord::Migration[5.1]
  def change
    add_column :reserves, :status, :integer
  end
end
