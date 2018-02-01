class CreateSaleredetails < ActiveRecord::Migration[5.1]
  def change
    create_table :saleredetails do |t|
      t.integer :sale_id
      t.float :number
      t.float :price
      t.float :sum
      t.integer :salere_id

      t.timestamps
    end
  end
end
