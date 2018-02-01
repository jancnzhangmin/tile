class AddIsnewToReserve < ActiveRecord::Migration[5.1]
  def change
    add_column :reserves, :isnew, :integer
  end
end
