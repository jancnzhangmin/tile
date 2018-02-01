class AddIsnewToInrawdepot < ActiveRecord::Migration[5.1]
  def change
    add_column :inrawdepots, :isnew, :integer
  end
end
