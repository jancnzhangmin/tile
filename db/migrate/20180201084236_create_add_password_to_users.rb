class CreateAddPasswordToUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :add_password_to_users do |t|
      t.string :password_digest

      t.timestamps
    end
  end
end
