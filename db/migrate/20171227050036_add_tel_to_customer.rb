class AddTelToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :name, :string
    add_column :customers, :tel, :string
    add_column :customers, :region, :string
  end
end
