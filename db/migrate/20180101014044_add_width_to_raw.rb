class AddWidthToRaw < ActiveRecord::Migration[5.1]
  def change
    add_column :raws, :width, :float
    add_column :raws, :height, :float
  end
end
