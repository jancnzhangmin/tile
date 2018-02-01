class CreateInnewdepotdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :innewdepotdetails do |t|
      t.integer :innewdepot_id
      t.integer :newraw_id
      t.float :price
      t.float :number
      t.float :sum
      t.float :width
      t.float :height

      t.timestamps
    end
  end
end
