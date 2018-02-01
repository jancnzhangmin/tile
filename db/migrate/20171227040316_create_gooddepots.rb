class CreateGooddepots < ActiveRecord::Migration[5.1]
  def change
    create_table :gooddepots do |t|
      t.integer :good_id
      t.float :number

      t.timestamps
    end
  end
end
