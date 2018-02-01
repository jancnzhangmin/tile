class AddInnewrawToInrawdepotdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :inrawdepotdetails, :innewraw_id, :integer
  end
end
