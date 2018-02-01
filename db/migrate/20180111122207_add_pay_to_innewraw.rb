class AddPayToInnewraw < ActiveRecord::Migration[5.1]
  def change
    add_column :innewraws, :pay, :float
  end
end
