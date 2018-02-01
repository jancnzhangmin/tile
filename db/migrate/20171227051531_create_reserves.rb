class CreateReserves < ActiveRecord::Migration[5.1]
  def change
    create_table :reserves do |t|
      t.integer :customer_id
      t.string :ordernumber
      t.datetime :orderdate
      t.string :summary

      t.timestamps
    end
  end
end
