class AddInstalldateToPreorder < ActiveRecord::Migration[5.1]
  def change
    add_column :preorders, :installdate, :datetime
  end
end
