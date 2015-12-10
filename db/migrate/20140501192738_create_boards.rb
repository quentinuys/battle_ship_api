class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :game_id
      t.integer :height
      t.integer :width
      t.integer :grid_width
      t.integer :grid_height

      t.timestamps
    end
  end
end
