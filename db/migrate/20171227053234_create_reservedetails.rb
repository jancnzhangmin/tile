class CreateReservedetails < ActiveRecord::Migration[5.1]
  def change
    create_table :reservedetails do |t|

      t.float :number

      t.timestamps
    end
  end
end
