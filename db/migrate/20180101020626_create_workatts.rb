class CreateWorkatts < ActiveRecord::Migration[5.1]
  def change
    create_table :workatts do |t|
      t.string :name
      t.string :fa
      t.string :pinyin

      t.timestamps
    end
  end
end
