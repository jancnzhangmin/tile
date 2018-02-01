class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.string :name
      t.string :spec
      t.string :unit
      t.string :pinyin

      t.timestamps
    end
  end
end
