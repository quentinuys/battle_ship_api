class Nuke::NukeInteraction < Nuke::BaseInteraction

	attr_reader :hit_response

	def initialize(params)
		initialize_params(params)
		@game = Game.where{id == my{@id}}.first
	end

	def initialize_params(params)
		@id = params[:id]
		@x = params[:x]
		@y = params[:y]
	end

	def nuke!
		Nuke::NukeCmd.new(@game, @x, @y).tap do |cmd|
			cmd.take_hit
			@hit_response = cmd.hit_response
		end
	end
end