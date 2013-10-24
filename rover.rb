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
	end

	def go
		@num_rovers.times do |num|
			puts "Here's rover number #{num+1}!"
			move_rover(@rovers[num-1])
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

	def place_rover

	end

	def move_rover(rover)
		puts "I will move!"
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
mission.go
