class CreateCooperusers < ActiveRecord::Migration[5.1]
  def change
    create_table :cooperusers do |t|
      t.integer :cooper_id
      t.string :name
      t.string :tel
      t.string :usertype

      t.timestamps
    end
  end
end
