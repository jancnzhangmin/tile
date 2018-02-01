class CreateInworkdepots < ActiveRecord::Migration[5.1]
  def change
    create_table :inworkdepots do |t|
      t.string :ordernumber
      t.string :user
      t.string :summary

      t.timestamps
    end
  end
end
