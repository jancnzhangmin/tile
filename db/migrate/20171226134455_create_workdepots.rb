class CreateWorkdepots < ActiveRecord::Migration[5.1]
  def change
    create_table :workdepots do |t|
      t.integer :raw_id
      t.float :price
      t.float :number

      t.timestamps
    end
  end
end
