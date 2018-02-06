class AddCooperuserToCooper < ActiveRecord::Migration[5.1]
  def change
    add_column :coopers, :cooperuser, :string
    add_column :coopers, :cooperadmin, :string
  end
end
