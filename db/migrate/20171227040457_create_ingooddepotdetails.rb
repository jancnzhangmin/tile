class CreateIngooddepotdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :ingooddepotdetails do |t|
      t.integer :ingooddepot_id
      t.integer :good_id
      t.float :number
      t.string :sum
      t.string :float

      t.timestamps
    end
  end
end
