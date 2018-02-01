class CreateRaws < ActiveRecord::Migration[5.1]
  def change
    create_table :raws do |t|
      t.string :name
      t.string :spec
      t.string :unit
      t.string :price

      t.timestamps
    end
  end
end
