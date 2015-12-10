require 'httparty'
require 'json'

class Game::GameCmd < Game::BaseGameCmd

	attr_reader :game_id, :x, :y

	def execute!
		create_game
		initialize_id
		create_associated_models
		first_shot
	end


	def create_game
		@game ||= Game.create!(name: @name)
		@game.email = @email
		@game.game_status = "busy"
		@game.prize = nil
		@game.save!
	end

private


	def initialize_id
		@game_id = @game.id
	end

	def create_associated_models
		create_nuke
		create_board
		create_ship
	end

	def create_nuke
		Nuke::NukeCmd.new(@game,0,0).tap do |cmd|
			@nuke = cmd.random_hit
		end
	end

	def create_board
		Board::BoardCmd.new(@game).tap do |cmd|
			cmd.execute!
		end
	end

	def create_ship
		Ship::ShipCmd.new(@game).tap do	|cmd|
			cmd.execute!
		end
	end

	def first_shot
		@x = @nuke[:x_position]
		@y = @nuke[:y_position]
	end
end