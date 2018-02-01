class CreateNewworks < ActiveRecord::Migration[5.1]
  def change
    create_table :newworks do |t|
      t.string :ordernumber
      t.string :user
      t.string :summary
      t.integer :isnew
      t.string :preordernumber

      t.timestamps
    end
  end
end
