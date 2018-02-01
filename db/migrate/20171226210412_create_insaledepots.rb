class CreateInsaledepots < ActiveRecord::Migration[5.1]
  def change
    create_table :insaledepots do |t|
      t.string :ordernumber
      t.string :user
      t.string :summary
      t.integer :isnew

      t.timestamps
    end
  end
end
