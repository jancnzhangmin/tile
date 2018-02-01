class CreateNewrawspecs < ActiveRecord::Migration[5.1]
  def change
    create_table :newrawspecs do |t|
      t.integer :newraw_id
      t.float :width
      t.float :height

      t.timestamps
    end
  end
end
