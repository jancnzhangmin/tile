class CreatePreorders < ActiveRecord::Migration[5.1]
  def change
    create_table :preorders do |t|
      t.integer :newraw_id
      t.float :pay
      t.string :user
      t.integer :isnew
      t.string :ordernumber

      t.timestamps
    end
  end
end
