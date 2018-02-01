class AddUserToReserve < ActiveRecord::Migration[5.1]
  def change
    add_column :reserves, :user_id, :integer
  end
end
