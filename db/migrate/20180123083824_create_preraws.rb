class CreatePreraws < ActiveRecord::Migration[5.1]
  def change
    create_table :preraws do |t|
      t.string :name
      t.string :pinyin

      t.timestamps
    end
  end
end
