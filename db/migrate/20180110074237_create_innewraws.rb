class CreateInnewraws < ActiveRecord::Migration[5.1]
  def change
    create_table :innewraws do |t|
      t.string :ordernumber
      t.text :summary
      t.string :user
      t.integer :isnew
      t.integer :supplier_id

      t.timestamps
    end
  end
end
