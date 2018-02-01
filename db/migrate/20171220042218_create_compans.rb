class CreateCompans < ActiveRecord::Migration[5.1]
  def change
    create_table :compans do |t|
      t.string :name
      t.string :address
      t.string :tel
      t.string :bankdeposit
      t.string :bankaccount
      t.string :bankuser

      t.timestamps
    end
  end
end
