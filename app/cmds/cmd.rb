class Cmd

	def occupied_board_space(size, direction, x, y)
		space = []
		(0...size).to_a.each do |block|
			if direction == "vertical"
				space << {x:x, y:(y+block)}
			else
				space << {x:(x+block), y:y}
			end
		end
		space
	end
	
	def calculated_board_space
		board_space = []

		width = 10
		height = 10

		(1...width).to_a.each do |x|
			(1...height).to_a.each do |y|
			  board_space << {x:x, y:y}
			end		
		end
		board_space
	end
end