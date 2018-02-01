class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :idcard
      t.integer :sex
      t.string :tel
      t.datetime :entrydate
      t.datetime :quitdate

      t.timestamps
    end
  end
end
