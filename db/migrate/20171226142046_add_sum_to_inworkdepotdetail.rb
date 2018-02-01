class AddSumToInworkdepotdetail < ActiveRecord::Migration[5.1]
  def change
    add_column :inworkdepotdetails, :sum, :float
  end
end
