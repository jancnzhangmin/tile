class CreateNewdepots < ActiveRecord::Migration[5.1]
  def change
    create_table :newdepots do |t|
      t.integer :newraw_id

      t.timestamps
    end
  end
end
