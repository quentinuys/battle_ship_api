class BattleShip < API

	namespace :battleship do
		params do
			requires :name, desc: "User Name"
			requires :email, desc: "User Email"
		end

		desc "Register New Game"
		post 'register' do
			@register = Game::RegisterGameInteraction.new(params).tap do |interaction|
				interaction.execute!
			end
			status 200
			body @register.register_response
		end

		params do
			requires :id, desc: "Battleship id of current game"
			requires :x, desc: "X coordinates of nuke"
			requires :y, desc: "Y coordinates of nuke"
		end

		desc "nuke fired coordinates"
		post 'nuke' do
			@nuke = Nuke::NukeInteraction.new(params).tap do |interaction|
				interaction.nuke!
			end
			status 200
			body @nuke.hit_response
		end
	end
	
end