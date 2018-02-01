class AddCooperToPreorder < ActiveRecord::Migration[5.1]
  def change
    add_column :preorders, :cooper_id, :integer
    add_column :preorders, :cooperuser_id, :integer
  end
end
