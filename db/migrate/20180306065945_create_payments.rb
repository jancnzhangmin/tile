class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :paymenttype_id
      t.integer :customer_id
      t.string :paytype
      t.string :payordernumber
      t.float :pay

      t.timestamps
    end
  end
end
