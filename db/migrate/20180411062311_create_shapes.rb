class CreateShapes < ActiveRecord::Migration[5.1]
  def change
    create_table :shapes do |t|
      t.string :name
      t.float :x1
      t.float :x2
      t.float :y1
      t.float :y2
      t.float :cpx
      t.float :cpy
      t.float :width
      t.float :height
      t.float :x
      t.float :y
      t.float :cx
      t.float :cy
      t.float :rx
      t.float :ry
      t.float :cpx1
      t.float :cpy1
      t.string :text

      t.timestamps
    end
  end
end
