class CreateCooperdetails < ActiveRecord::Migration[5.1]
  def change
    create_table :cooperdetails do |t|
      t.string :contact
      t.string :ctype
      t.string :tel

      t.timestamps
    end
  end
end
