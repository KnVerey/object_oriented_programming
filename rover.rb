class Excursion	
	attr_accessor :plateau, :rovers, :num_rovers

	def initialize(array)
		create_grid(array.shift)
		@rovers = []
		@num_rovers = 0

		array.each do |rover_data| 
			@rovers[@num_rovers] = Rover.new(rover_data)
			@num_rovers +=1
		end
		
		place_rover
	end

	def print_location
		
	end

	def create_grid(coordinates)
		@plateau = []
		
		coordinates[0].times do |rows|
			row = []
			coordinates[1].times {|columns| row << "x"}
 			@plateau << row
		end
	end

	def print_grid
		@plateau.each do |rows|
			rows.each {|spot| print spot + "  "}
			puts
		end
	end

	def place_rover
		
		@plateau[@rovers[0].x, @rovers[1].y]	#ONLY WORKS FOR SPEC ROVER
	end

end

class Rover
	attr_accessor :x, :y, :heading, :instructions
	
	def initialize(rover_data)
		@x = (rover_data[0][0]).to_i
		@y = (rover_data[0][1]).to_i
		@heading = rover_data[0][2]
		@instructions = rover_data[1]
	end
end



input = [[5,5],
	[[1,2,"N"], ["LMLMLMLMM"]], 
	[[3,3,"E"], ["MMRMMRMRRM"]]]


mission = Excursion.new(input)
mission.print_grid