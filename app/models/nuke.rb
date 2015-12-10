class Nuke < ActiveRecord::Base

	attr_accessible :x_position, :y_position, :status

	belongs_to :game

end
