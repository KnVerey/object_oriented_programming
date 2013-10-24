class Excursion	
	attr_accessor :plateau, :squad, :num_rovers

	def initialize(array)
		create_grid(array.shift)
		@squad = []
		@num_rovers = 0

		array.each do |rover_data| 
			@squad[@num_rovers] = Rover.new(rover_data)
			@num_rovers +=1
		end
	end

	def go
		@num_rovers.times do |num|
			puts "Here's rover number #{num+1}!"
			move_rover(@squad[num-1])
		end

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

	def move_rover(rover)
		puts rover.instructions

		while rover.instructions != ""
			move = rover.instructions.slice!(0)


		end
	end

end

class Rover
	attr_accessor :x, :y, :heading, :instructions
	
	def initialize(rover_data)
		@x = (rover_data[0][0])
		@y = (rover_data[0][1])
		@heading = rover_data[0][2]
		@instructions = rover_data[1]
	end
end


input = [[5,5],
	[[1,2,"N"], "LMLMLMLMM"], 
	[[3,3,"E"], "MMRMMRMRRM"]]


mission = Excursion.new(input)
mission.go
