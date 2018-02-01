class CreateNewraws < ActiveRecord::Migration[5.1]
  def change
    create_table :newraws do |t|
      t.string :name
      t.string :unit
      t.string :price
      t.string :pinyin

      t.timestamps
    end
  end
end
