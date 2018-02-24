class AddUnitToPreraw < ActiveRecord::Migration[5.1]
  def change
    add_column :preraws, :unit, :string
  end
end
