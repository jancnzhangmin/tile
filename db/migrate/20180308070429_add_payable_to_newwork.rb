class AddPayableToNewwork < ActiveRecord::Migration[5.1]
  def change
    add_column :newworks, :payable, :float
  end
end
