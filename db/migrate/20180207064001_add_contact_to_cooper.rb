class AddContactToCooper < ActiveRecord::Migration[5.1]
  def change
    add_column :coopers, :contact, :string
    add_column :coopers, :contacttel, :string
  end
end
