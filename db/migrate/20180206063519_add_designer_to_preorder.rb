class AddDesignerToPreorder < ActiveRecord::Migration[5.1]
  def change
    add_column :preorders, :designer_id, :integer
    add_column :preorders, :fiter_id, :integer
  end
end
