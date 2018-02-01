class CreateSaleres < ActiveRecord::Migration[5.1]
  def change
    create_table :saleres do |t|
      t.integer :customer_id
      t.string :ordernumber
      t.text :summary
      t.string :user

      t.timestamps
    end
  end
end
