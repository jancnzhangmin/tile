class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.string :name
      t.string :spec
      t.string :unit
      t.float :cost
      t.float :price
      t.string :pinyin

      t.timestamps
    end
  end
end
