class CreateBorrowgoods < ActiveRecord::Migration[5.1]
  def change
    create_table :borrowgoods do |t|
      t.string :ordernumber
      t.integer :borrowuser_id
      t.integer :user_id
      t.string :summary

      t.timestamps
    end
  end
end
