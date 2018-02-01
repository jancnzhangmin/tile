class CreateCoopers < ActiveRecord::Migration[5.1]
  def change
    create_table :coopers do |t|
      t.string :name
      t.string :address
      t.string :tel
      t.string :bankdeposit
      t.string :bankaccount
      t.string :bankuser
      t.string :content

      t.timestamps
    end
  end
end
