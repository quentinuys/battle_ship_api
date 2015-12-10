require 'json'
require 'grape/rabl'

class	API < Grape::API
	format :json
	formatter :json, Grape::Formatter::Rabl

	mount BattleShip
end
