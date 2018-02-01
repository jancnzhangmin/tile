class AddNumberToNewrawspec < ActiveRecord::Migration[5.1]
  def change
    add_column :newrawspecs, :number, :float
  end
end
