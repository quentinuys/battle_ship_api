class CreateNukes < ActiveRecord::Migration
  def change
    create_table :nukes do |t|
      t.integer :game_id
      t.integer :x_position
      t.integer :y_position
      t.string :status

      t.timestamps
    end
  end
end
