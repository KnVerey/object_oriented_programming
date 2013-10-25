class Location
	def initialize(coordinates)
		@plateau = []
		
		(coordinates[0]+1).times do |rows|
			row = []
			(coordinates[1]+1).times {|columns| row << "·"}
 			@plateau << row
		end
	end

	def print_grid
		@plateau.each do |rows|
			rows.each {|spot| print spot + "  "}
			puts
		end
	end

	def record_position(x,y,heading)
		@plateau[x][y] = "O"
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
			current_rover=@squad[num]
			@grid.record_position(current_rover.x, current_rover.y, current_rover.heading)

			print "Rover #{num+1} stopped here: "
			instr_rover(current_rover)
			current_rover.print_location
			@grid.print_grid			
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
			@grid.record_position(rover.x, rover.y, current_rover.heading)
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
	 		case @heading
			when "N"
				@heading = "E" 
			when "E"
				@heading = "S" 
			when "S"
				@heading = "W" 
			when "W"
				@heading = "N" 
			end

 		elsif instr == "L"
 			case @heading
 			when "N"
 				@heading = "W"
 			when "E"
 				@heading = "N"
 			when "S"
 				@heading = "E"
 			when "W"
 				@heading = "S"
 			end
		end
	end

	def move
		@y += 1 if @heading == "N"
		@x += 1 if @heading == "E"
		@y -= 1 if @heading == "S"
		@x -= 1 if @heading == "W"
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
