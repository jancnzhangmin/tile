class AddPinyinToSupplier < ActiveRecord::Migration[5.1]
  def change
    add_column :suppliers, :pinyin, :string
  end
end
