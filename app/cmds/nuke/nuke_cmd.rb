require 'httparty'
require 'json'

class Nuke::NukeCmd < Nuke::BaseNukeCmd
	
	attr_reader :hit_response

	def take_hit
		nuke_it(@x, @y, "received")
		nuke_clever
		get_hit_response		
		nuke_it(@x_fire, @y_fire, "fired")


	end

	def random_hit
		nuke = random_nuke
		@x_fire = nuke[:x]
		@y_fire = nuke[:y]
		{x_position: @x_fire, y_position: @y_fire, status: nil}
		nuke_it(@x_fire, @y_fire, "fired")
	end

	def nuke_it(x, y, type_status)
		@nuke = @game.nukes.create!(x_position: x, y_position: y,	status: type_status)
	end

private

	def nuke_clever
		nuke_spot = random_nuke
		@x_fire = nuke_spot[:x]
		@y_fire = nuke_spot[:y]
	end

	def get_hit_response
		ship = ship_hit
		if ship
			status = "hit"
			sunk = ship_has_sunk?(ship) ? ship.name : nil
			update_ship(ship) if sunk
		else
			status = "miss"
			sunk = nil
		end
		game_status = game_lost? ? "lost" : nil
		prize = game_lost? ? "Congratsulations" : nil

		@hit_response = {id:@game.id, x:@x_fire, y:@y_fire, status:status, sunk:sunk, game_status: game_status, error: nil, prize: prize }
	end

	def update_ship(ship)
		ship.update_attributes(status: "sunk")
	end

	def game_lost?
		@game.ships.where{status == "live"}.none?
	end

	def ship_has_sunk?(ship)
		occupied_board_space(ship.size, ship.direction, ship.location_x, ship.location_y).each do |sp|
			return false if @game.nukes.where{(x_position == sp[:x]) & (y_position == sp[:y]) & (status == "received")}.none?
		end
		true
	end

	def ship_hit
		@game.ships.each do |ship|
			occupied_board_space(ship.size, ship.direction, ship.location_x, ship.location_y).each do |space|
				return ship if ((space[:x] == @x) & (space[:y] == @y))
			end
		end
		nil
	end

	def last_hit_sunk?
		ships_sunk.each do |ss|
			return true if ((ss.location_x == last_hit[:x]) & (ss.location_y == last_hit[:y]))
		end
		false
	end

	def ships_sunk
		@game.ships.where{status == "sunk"}
	end

	def ships_sunk?
		@game.ships.where{status == "sunk"}.any?
	end

	def fired_at
		fired_at = []
		@game.nukes.where{status == "fired"}.each{|nuke| fired_at << {x: nuke.x_position, y: nuke.y_position}}
		fired_at
	end

	def board_space
		@board_space ||= calculated_board_space
	end

	def random_nuke
		available_nuke_space.sample
	end

	def available_nuke_space
		board_space.reject{|bs| fired_at.include?({x:bs[:x], y:bs[:y]}) }
	end

	def status
		@hit_response["status"]
	end

end