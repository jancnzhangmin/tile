class CreateInsaledepotdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :insaledepotdetails do |t|
      t.integer :insaledepot_id
      t.integer :raw_id
      t.float :rawprice
      t.float :rawnumber
      t.integer :sale_id
      t.float :saleprice
      t.float :salenumber
      t.float :salesum
      t.float :rawsum

      t.timestamps
    end
  end
end
