class CreateSaledetails < ActiveRecord::Migration[5.1]
  def change
    create_table :saledetails do |t|
      t.integer :raw_id
      t.integer :sale_id
      t.float :number
      t.float :price

      t.timestamps
    end
  end
end
