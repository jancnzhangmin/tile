class AddAddressToPreorder < ActiveRecord::Migration[5.1]
  def change
    add_column :preorders, :address, :string
  end
end
