class AddContentToNewdepotdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :newdepotdetails, :content, :text
  end
end
