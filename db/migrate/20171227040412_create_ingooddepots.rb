class CreateIngooddepots < ActiveRecord::Migration[5.1]
  def change
    create_table :ingooddepots do |t|
      t.string :ordernumber
      t.text :summary
      t.string :user
      t.integer :isnew

      t.timestamps
    end
  end
end
