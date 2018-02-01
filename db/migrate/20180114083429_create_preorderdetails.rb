class CreatePreorderdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :preorderdetails do |t|
      t.integer :preorder_id
      t.integer :newraw_id
      t.float :width
      t.float :height
      t.float :sum
      t.string :area
      t.string :summary

      t.timestamps
    end
  end
end
