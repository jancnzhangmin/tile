class CreatePrefixorders < ActiveRecord::Migration[5.1]
  def change
    create_table :prefixorders do |t|
      t.string :raw
      t.string :preorder
      t.string :work

      t.timestamps
    end
  end
end
