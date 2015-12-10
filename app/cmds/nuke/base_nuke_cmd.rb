class Nuke::BaseNukeCmd < Cmd 

	def initialize(game, x, y)
		@game = game
		@x = x
		@y = y
	end

end