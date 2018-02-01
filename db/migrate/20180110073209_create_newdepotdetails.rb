class CreateNewdepotdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :newdepotdetails do |t|
      t.integer :newdepot_id
      t.float :width
      t.float :height
      t.float :price
      t.float :number

      t.timestamps
    end
  end
end
