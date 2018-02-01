class AddIsnewToSale < ActiveRecord::Migration[5.1]
  def change
    add_column :sales, :isnew, :integer
  end
end
