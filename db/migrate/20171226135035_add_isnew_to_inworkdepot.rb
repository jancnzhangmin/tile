class AddIsnewToInworkdepot < ActiveRecord::Migration[5.1]
  def change
    add_column :inworkdepots, :isnew, :integer
  end
end
