class AddLossareaToNewworkdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :newworkdetails, :lossarea, :float
  end
end
