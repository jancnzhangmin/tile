class AddBorrownumberToGooddepot < ActiveRecord::Migration[5.1]
  def change
    add_column :gooddepots, :borrownumber, :float
  end
end
