class AddPinyinToRaw < ActiveRecord::Migration[5.1]
  def change
    add_column :raws, :pinyin, :string
  end
end
