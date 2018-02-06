class CreateFiters < ActiveRecord::Migration[5.1]
  def change
    create_table :fiters do |t|
      t.string :name
      t.string :tel

      t.timestamps
    end
  end
end
