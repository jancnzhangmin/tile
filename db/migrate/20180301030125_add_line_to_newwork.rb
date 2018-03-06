class AddLineToNewwork < ActiveRecord::Migration[5.1]
  def change
    add_column :newworks, :line, :integer
    add_column :newworks, :wave, :integer
  end
end
