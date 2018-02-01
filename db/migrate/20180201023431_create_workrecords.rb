class CreateWorkrecords < ActiveRecord::Migration[5.1]
  def change
    create_table :workrecords do |t|
      t.integer :newraw_id
      t.integer :newwork_id
      t.float :width
      t.float :height
      t.float :userheight
      t.float :price
      t.float :number

      t.timestamps
    end
  end
end
