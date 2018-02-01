class AddAuthToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auth, :text
  end
end
