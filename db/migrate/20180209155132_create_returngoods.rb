class CreateReturngoods < ActiveRecord::Migration[5.1]
  def change
    create_table :returngoods do |t|
      t.string :ordernumber
      t.integer :returnuser_id
      t.integer :user_id
      t.integer :isnew

      t.timestamps
    end
  end
end
