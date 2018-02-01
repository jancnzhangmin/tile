class AddSupplieridToInrawdepot < ActiveRecord::Migration[5.1]
  def change
    add_column :inrawdepots, :supplier_id, :integer
  end
end
