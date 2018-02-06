class CreateAddCooperuserToCoopers < ActiveRecord::Migration[5.1]
  def change
    create_table :add_cooperuser_to_coopers do |t|
      t.string :cooperuser
      t.string :cooperadmin

      t.timestamps
    end
  end
end
