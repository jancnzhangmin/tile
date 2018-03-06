class AddPaymenttypeToPreorder < ActiveRecord::Migration[5.1]
  def change
    add_column :preorders, :paymenttype_id, :integer
  end
end
