class Person
	attr_accessor :name

	def greeting
		puts "Hi, my name is #{@name}"
	end
end

class Student < Person
	def learn
		puts "I get it!"
	end
end

class Instructor < Person
	def teach
		puts "Everything in Ruby is an Object."
	end
end

chris = Instructor.new
chris.name = "Chris"
chris.greeting

christina = Student.new
christina.name = "Christina"
christina.greeting