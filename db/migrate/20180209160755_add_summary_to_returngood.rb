class AddSummaryToReturngood < ActiveRecord::Migration[5.1]
  def change
    add_column :returngoods, :summary, :string
  end
end
