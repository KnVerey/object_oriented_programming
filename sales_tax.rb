#Some of the rounding output doesn't 100% match the solution: forgot not to round values that are already at 5
#Add formatting method
#use class method to track the total tax and price?

class Bill
	attr_accessor :products, :total_tax
	
	def initialize(input)
		@products= []
		counter = 0
		input.each do |name, price, quantity|
			@products[counter] = Item.new(name, price, quantity)
			counter += 1
		end

		@total_tax= sum_tax()
	end

	def sum_tax
		@products.inject(0) {|sum, item| sum+item.tax}.to_f/100
	end

	def sum_total
		(@products.inject(0)	{|sum, item| sum+item.price}.to_f/100) + @total_tax
	end

	def print_all_items
		@products.each {|item| item.print_item}
	end

	def print_receipt
		print_all_items()
		puts "Sales Taxes: $#{'%.2f' % @total_tax}"
		puts "Total: $#{'%.2f' % sum_total}"
	end

end	


class Item
	attr_accessor :name, :price, :quantity, :tax

	def initialize(name, price, quantity)
		@name = name
		@price = (price*100).to_i
		@quantity = quantity.to_i
		@tax = tax()
	end

	def tax_rate
		exempted = ["book", "chocolate", "pill"]

		if @name.include?("imported") && exempted.any? {|exi| @name.include?(exi)}
			return 5
		elsif exempted.any? {|exi| @name.include?(exi)}
			return 0
		elsif @name.include?("imported")
			return 15
		else
			return 10
		end
	end

	def tax_round(unrounded)
		return unrounded if unrounded%5==0
		(unrounded - unrounded%5) + 5
	end

	def tax
		tax_round(tax_rate*@price/100)
	end

	def print_item
		puts "#{@quantity} #{@name}: $#{'%.2f' % (((@price+@tax)*@quantity).to_f/100)}"
	end

end


input1 = [
	["book", 12.49, 1],
	["music CD", 14.99, 1],
	["chocolate bar", 0.85, 1]
]

input2 = [
	["imported box of chocolates", 10.00, 1],
	["imported bottle of perfume", 47.50, 1]
]

input3 = [
	["imported bottle of perfume", 27.99, 1],
	["bottle of perfume", 18.99, 1],
	["headache pills", 9.75, 1],
	["box of imported chocolates", 11.25, 1]
]

puts "\nBill 1:"
Bill.new(input1).print_receipt

puts "\nBill 2:"
Bill.new(input2).print_receipt

puts "\nBill 3:"
Bill.new(input3).print_receipt
