class CreateNewworkdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :newworkdetails do |t|
      t.integer :newwork_id
      t.integer :newraw_id
      t.float :width
      t.float :height
      t.float :userheight
      t.string :widthtype
      t.string :heighttype
      t.float :number

      t.timestamps
    end
  end
end
