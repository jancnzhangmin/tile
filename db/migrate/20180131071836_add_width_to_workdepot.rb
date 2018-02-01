class AddWidthToWorkdepot < ActiveRecord::Migration[5.1]
  def change
    add_column :workdepots, :newraw_id, :integer
    add_column :workdepots, :width, :float
    add_column :workdepots, :height, :float
    add_column :workdepots, :userheight, :float
  end
end
