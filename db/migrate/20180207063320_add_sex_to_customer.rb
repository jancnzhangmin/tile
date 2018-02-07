class AddSexToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :sex, :integer
  end
end
