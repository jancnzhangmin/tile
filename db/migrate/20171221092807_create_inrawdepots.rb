class CreateInrawdepots < ActiveRecord::Migration[5.1]
  def change
    create_table :inrawdepots do |t|
      t.string :ordernumber
      t.text :summary
      t.string :user

      t.timestamps
    end
  end
end
