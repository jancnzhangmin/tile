class CreateWorkattches < ActiveRecord::Migration[5.1]
  def change
    create_table :workattches do |t|
      t.string :name
      t.string :fa
      t.string :pinyin

      t.timestamps
    end
  end
end
