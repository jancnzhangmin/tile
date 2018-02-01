class AddWorkordernumberToWorkrecord < ActiveRecord::Migration[5.1]
  def change
    add_column :workrecords, :worknumber, :string
  end
end
