class Location
	def initialize(coordinates)
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
end


class Excursion	
	def initialize(array)
		@grid = Location.new(array.shift)
		@squad = []
		@num_rovers = 0

		array.each do |rover_data|
			@squad[@num_rovers] = Rover.new(rover_data)
			@num_rovers +=1
		end
	end

	def go
		0.upto(@num_rovers-1) do |num|
			puts "Here's rover number #{num+1}!"
			instr_rover(@squad[num])
		end
	end

	def instr_rover(rover)
		until rover.instructions == ""
			instr = rover.instructions.slice!(0)
			if instr == "R" || instr == "L"
				rover.turn(instr)
			elsif instr=="M"
				rover.move()
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
		@x = rover_data[0][0]
		@y = rover_data[0][1]
		@heading = rover_data[0][2]
		@instructions = rover_data[1]
	end

	def turn(instr)
		if instr == "R" 
 			@heading = "E" if @heading == "N"
 			@heading = "S" if @heading == "E"
 			@heading = "W" if @heading == "S"
 			@heading = "N" if @heading == "W"
 		elsif instr == "L"
 			@heading = "W" if @heading == "N"
 			@heading = "N" if @heading == "E"
 			@heading = "E" if @heading == "S"
 			@heading = "S" if @heading == "W"
		end
		#print_location
	end

	def move()
		@y += 1 if @heading == "N"
		@x += 1 if @heading == "E"
		@y -= 1 if @heading == "S"
		@x -= 1 if @heading == "W"
		#print_location
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
