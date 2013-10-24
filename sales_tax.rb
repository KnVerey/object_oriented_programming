#One of the results for input 3 is off by 1 cent
#use class method to track the total tax and price?

module Formatting
	def self.monetize(num)
		"$" + ('%.2f' % (num.to_f/100))
	end
end

class Receipt
	include Formatting
	attr_accessor :products, :total_price, :total_tax, :num_items

	def initialize(input)
		@total_price = 0
		@total_tax = 0
		@num_items = 0 

		@products = []
		input.each do |name, price, quantity|
			@products[@num_items] = Item.new(name, price, quantity)
			@total_price += @products[@num_items].total
			@total_tax += @products[@num_items].tax
			@num_items += 1
		end
	end

	def print_all_items
		@products.each {|item| item.print_item}
	end

	def print_receipt
		print_all_items()
		puts "Sales Taxes: #{Formatting::monetize(@total_tax)}"
		puts "Total: #{Formatting::monetize(@total_price)}"
	end

end	


class Item
	include Formatting
	attr_accessor :name, :price, :quantity, :tax, :total

	def initialize(name, price, quantity)
		@name = name
		@price = (price*100).to_i
		@quantity = quantity.to_i
		@tax = tax()
		@total = (@price + @tax) * @quantity
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
		unrounded - unrounded%5 + 5
	end

	def tax
		tax_round(tax_rate*@price/100)
	end

	def print_item
		puts "#{@quantity} #{@name}: #{Formatting::monetize(@total)}"
	end

end

# class Imported < Item
# 	def tax_rate
# 		super + 5
# 	end
# end

# class Exempt < Item
# 	def tax_rate
# 		0
# 	end
# end

# class ImportedExempt < Exempt
# 	def tax_rate
# 		super + 10
# 	end
# end

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

puts "\nReceipt 1:"
Receipt.new(input1).print_receipt

puts "\nReceipt 2:"
Receipt.new(input2).print_receipt

puts "\nReceipt 3:"
Receipt.new(input3).print_receipt
