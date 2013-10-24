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
			instr_rover(@squad[num-1])
			@squad[num-1].print_location
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

	def turn(rover, instr)
		if instr == "R" 
 			rover.heading = "E" if rover.heading == "N"
 			rover.heading = "S" if rover.heading == "E"
 			rover.heading = "W" if rover.heading == "S"
 			rover.heading = "N" if rover.heading == "W"
 		elsif instr == "L"
 			rover.heading = "W" if rover.heading == "N"
 			rover.heading = "N" if rover.heading == "E"
 			rover.heading = "E" if rover.heading == "S"
 			rover.heading = "S" if rover.heading == "W"
		end
	end

	def move(rover)
		rover.y += 1 if rover.heading == "N"
		rover.x += 1 if rover.heading == "E"
		rover.y -= 1 if rover.heading == "S"
		rover.x -= 1 if rover.heading == "W"
	end

	def instr_rover(rover)
		until rover.instructions == ""
			instr = rover.instructions.slice!(0)

			if instr == "R" || instr == "L"
				turn(rover, instr)
			elsif instr=="M"
				move(rover)
			else
				puts "Invalid instructions! Abort!"
				break
			end
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

	def print_location
		puts @x.to_s + " " + @y.to_s + " " + @heading
	end
end


input = [[5,5],
	[[1,2,"N"], "LMLMLMLMM"], 
	[[3,3,"E"], "MMRMMRMRRM"]]


mission = Excursion.new(input)
mission.go
