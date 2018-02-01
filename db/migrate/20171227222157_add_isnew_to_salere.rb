class AddIsnewToSalere < ActiveRecord::Migration[5.1]
  def change
    add_column :saleres, :isnew, :integer
  end
end
