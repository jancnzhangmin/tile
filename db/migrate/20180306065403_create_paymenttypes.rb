class CreatePaymenttypes < ActiveRecord::Migration[5.1]
  def change
    create_table :paymenttypes do |t|
      t.string :paymenttype

      t.timestamps
    end
  end
end
