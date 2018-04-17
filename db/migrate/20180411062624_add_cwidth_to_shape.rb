class AddCwidthToShape < ActiveRecord::Migration[5.1]
  def change
    add_column :shapes, :cwidth, :integer
    add_column :shapes, :cheight, :integer
  end
end
