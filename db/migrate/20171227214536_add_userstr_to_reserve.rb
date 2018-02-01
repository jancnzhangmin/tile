class AddUserstrToReserve < ActiveRecord::Migration[5.1]
  def change
    add_column :reserves, :user, :string
  end
end
