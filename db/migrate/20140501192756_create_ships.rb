class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :game_id
      t.string :name
      t.integer :size
      t.string :status
      t.integer :location_x
      t.integer :location_y
      t.string :direction

      t.timestamps
    end
  end
end
