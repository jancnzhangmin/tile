class AddPreorderToInworkdepot < ActiveRecord::Migration[5.1]
  def change
    add_column :inworkdepots, :preordernumber, :string
  end
end
