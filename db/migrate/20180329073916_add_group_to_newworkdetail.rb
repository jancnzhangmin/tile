class AddGroupToNewworkdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :newworkdetails, :group, :string
  end
end
