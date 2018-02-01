class AddCustomeridToPreorder < ActiveRecord::Migration[5.1]
  def change
    add_column :preorders, :customer_id, :integer
  end
end
