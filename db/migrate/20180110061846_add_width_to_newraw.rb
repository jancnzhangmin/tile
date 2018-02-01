class AddWidthToNewraw < ActiveRecord::Migration[5.1]
  def change
    add_column :newraws, :width, :float
    add_column :newraws, :height, :float
  end
end
