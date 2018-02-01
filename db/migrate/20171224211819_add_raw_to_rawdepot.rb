class AddRawToRawdepot < ActiveRecord::Migration[5.1]
  def change
    add_column :rawdepots, :raw_id, :integer
    add_column :rawdepots, :number, :float
    add_column :rawdepots, :price, :float
  end
end
