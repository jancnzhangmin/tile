class CreateBorrowgooddetails < ActiveRecord::Migration[5.1]
  def change
    create_table :borrowgooddetails do |t|
      t.integer :borrowgood_id
      t.integer :good_id
      t.float :number

      t.timestamps
    end
  end
end
