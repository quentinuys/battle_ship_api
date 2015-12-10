class Board < ActiveRecord::Base

	attr_accessible :height, :width, :grid_height, :grid_width
	belongs_to :game
end
