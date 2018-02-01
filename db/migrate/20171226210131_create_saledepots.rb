class CreateSaledepots < ActiveRecord::Migration[5.1]
  def change
    create_table :saledepots do |t|
      t.integer :sale_id
      t.float :number
      t.float :price

      t.timestamps
    end
  end
end
