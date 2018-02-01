class AddPayToReserve < ActiveRecord::Migration[5.1]
  def change
    add_column :reserves, :pay, :float
  end
end
