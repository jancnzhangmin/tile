class CreateReturngooddetails < ActiveRecord::Migration[5.1]
  def change
    create_table :returngooddetails do |t|
      t.integer :returngood_id
      t.integer :good_id
      t.float :number

      t.timestamps
    end
  end
end
