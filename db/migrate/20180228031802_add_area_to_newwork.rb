class AddAreaToNewwork < ActiveRecord::Migration[5.1]
  def change
    add_column :newworks, :area, :string
  end
end
