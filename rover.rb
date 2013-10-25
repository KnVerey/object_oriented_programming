class Location
	attr_reader :plateau

	def initialize(coordinates)
		@x_size = coordinates[0]
		@y_size = coordinates[1]
		@plateau = []
		
		(@x_size+1).times do |rows|
			row = []
			(@y_size+1).times {|columns| row << "·"}
 			@plateau << row
		end
	end

	def print_grid
		puts "\nMAP: '*' appears before starting point and after stop point."
		puts "Actions occurring in a single location are listed left to right.\n"
		@x_size.downto(0) do |row_no|
			0.upto(@y_size) do |column_no|
				print @plateau[column_no][row_no] + "\t\t"
			end
			puts "\n\n"
		end

	end
end


class Excursion	
	def initialize(array)
		@grid = Location.new(array.shift)
		@squad = []
		@num_rovers = 0

		array.each do |rover_data|
			@squad[@num_rovers] = Rover.new(rover_data, @num_rovers+1)
			@num_rovers +=1
		end
	end

	def go
		0.upto(@num_rovers-1) do |num|
			current_rover=@squad[num]
			current_rover.record_position(@grid)
			current_rover.mark_start(@grid)

			instr_rover(current_rover)
			puts "\nRover #{num+1} stopped at #{current_rover.location}."
			current_rover.mark_end(@grid)
		end
			@grid.print_grid			
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
			rover.record_position(@grid)
		end
	end

end

class Rover
	attr_accessor :instructions
	attr_reader :x, :y, :heading
	
	def initialize(rover_data, num)
		@x = rover_data[0][0]
		@y = rover_data[0][1]
		@heading = rover_data[0][2]
		@instructions = rover_data[1]
		@rover_num = num
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

	def location
		@x.to_s + " " + @y.to_s + " " + @heading
	end

	def choose_arrow
		return "→" if @heading=="E"
		return "←" if @heading=="W"
		return "↑" if @heading=="N"
		return "↓" if @heading=="S"
	end

	def record_position(grid)
		position = grid.plateau[x][y]
		new_value = @rover_num.to_s + choose_arrow 
		if position == "·"
			position.replace new_value
		else
			position << new_value
		end
	end

	def mark_start(grid)
		grid.plateau[x][y].insert(0,"*")
	end

	def mark_end(grid)
		grid.plateau[x][y].insert(-1,"*")
	end
end


input = [[5,5],
	[[1,2,"N"], "LMLMLMLMM"], 
	[[3,3,"E"], "MMRMMRMRRM"]]

Excursion.new(input).go
