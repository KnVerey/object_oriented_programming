class Excursion	
	attr_accessor :plateau, :rovers

	def initialize(array)
		@plateau = Grid.new(array.shift)
		@rovers = array.each { |rover_data| Rover.new(rover_data)}
		puts @rovers.to_s

		
	end

	def print_location
		
	end
end

class Grid

	def initialize(coordinates)
		
	end
end

class Rover
	attr_accessor :x, :y, :heading, :instructions
	
	def initialize(rover_data)
		@x = rover_data[0,0]
		@y = rover_data[0,1]
		@heading = rover_data[0,3]
		@instructions = rover_data[1]	
	end

end



input = [[5,5],
	[[1,2,"N"], ["LMLMLMLMM"]], 
	[[3,3,"E"], ["MMRMMRMRRM"]]]


Excursion.new(input)