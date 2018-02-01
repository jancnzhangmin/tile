class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :address
      t.string :tel
      t.string :bankdeposit
      t.string :bankaccount
      t.string :bankuser
      t.float :amount

      t.timestamps
    end
  end
end
