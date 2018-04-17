class CreateColorlibs < ActiveRecord::Migration[5.1]
  def change
    create_table :colorlibs do |t|
      t.string :serial
      t.string :color

      t.timestamps
    end
  end
end
