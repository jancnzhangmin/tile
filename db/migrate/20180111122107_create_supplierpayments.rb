class CreateSupplierpayments < ActiveRecord::Migration[5.1]
  def change
    create_table :supplierpayments do |t|
      t.integer :supplier_id
      t.float :pay
      t.string :summary

      t.timestamps
    end
  end
end
