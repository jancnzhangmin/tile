class AddSummaryToInnewdepotdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :innewdepotdetails, :summary, :string
  end
end
