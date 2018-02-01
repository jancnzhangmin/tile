class CreateInworkdepotdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :inworkdepotdetails do |t|
      t.integer :inworkdepot_id
      t.integer :raw_id
      t.float :price
      t.float :number

      t.timestamps
    end
  end
end
