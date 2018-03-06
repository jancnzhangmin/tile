class AddAreaToNewworkdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :newworkdetails, :area, :string
  end
end
