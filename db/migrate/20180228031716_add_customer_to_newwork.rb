class AddCustomerToNewwork < ActiveRecord::Migration[5.1]
  def change
    add_column :newworks, :cooper_id, :integer
    add_column :newworks, :customer_id, :integer
    add_column :newworks, :designer_id, :integer
    add_column :newworks, :fiter_id, :integer
  end
end
