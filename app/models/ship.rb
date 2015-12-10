class Ship < ActiveRecord::Base
	attr_accessible :name, :size, :status, :location_x, :location_y, :direction 
	belongs_to :game
end
