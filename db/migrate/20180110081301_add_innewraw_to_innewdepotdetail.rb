class AddInnewrawToInnewdepotdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :innewdepotdetails, :innewraw_id, :integer
  end
end
