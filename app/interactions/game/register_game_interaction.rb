class Game::RegisterGameInteraction < Game::BaseInteraction

	attr_reader :register_response

	def initialize(params)
		initialize_params(params)
	end

	def initialize_params(params)
		@name = params[:name]
		@email = params[:email]
	end

	def execute!
		register!
		get_response
	end

	def register!
		Game::GameCmd.new(@name, @email).tap do |cmd|
			cmd.execute!
			@game_id = cmd.game_id
			@x			 = cmd.x
			@y			 = cmd.y
		end
	end

	def get_response
		@register_response = {:id => @game_id, :x => @x, :y => @y}
	end

end