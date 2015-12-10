class Game < ActiveRecord::Base

	attr_accessible :name, :email
	
	has_many :boards
	has_many :nukes
	has_many :ships
end
