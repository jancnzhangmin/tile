class AddNewworkdetailidToShape < ActiveRecord::Migration[5.1]
  def change
    add_column :shapes, :newworkdetail_id, :integer
  end
end
