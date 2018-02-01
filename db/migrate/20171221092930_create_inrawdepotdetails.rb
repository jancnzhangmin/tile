class CreateInrawdepotdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :inrawdepotdetails do |t|
      t.integer :inrawdepot_id
      t.integer :supplier_id
      t.integer :raw_id
      t.float :price
      t.float :number
      t.float :sum

      t.timestamps
    end
  end
end
