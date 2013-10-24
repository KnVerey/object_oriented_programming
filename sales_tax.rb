
class Goods
	attr_accessor :item, :price, :quantity, :tax

	def initialize(item, price, quantity)
		@item = item
		@price = price
		@quantity = quantity
		@tax = tax()
	end

	def tax_rate
		exempted = ["book", "chocolate", "pill"]

		if @item.include?("imported") && exempted.any? {|exi| @item.include?(exi)}
			return 5
		elsif exempted.any? {|exi| @item.include?(exi)}
			return 0
		elsif @item.include?("imported")
			return 15
		else
			return 10
		end
	end

	def tax
		rate = tax_rate()
		return (rate*@quantity*@price/100).round(-1)
	end

	def receipt
		puts "#{@quantity} #{@item}: #{(@price.to_f*quantity+@tax.to_f)/100}"
	end
end


# input1 = [
# 	"book", 12.49, 1],
# 	"music", 14.99, 1],
# 	"chocolate bar", 0.85, 1]
# ]

# input2 = [
# 	"imported box of chocolates", 10.00, 1],
# 	"imported bottle of perfume", 47.50, 1]
# ]

input3 = [
	["imported bottle of perfume", 27.99, 1],
	["bottle of perfume", 18.99, 1],
	["headache pills", 9.75, 1],
	["box of imported chocolates", 11.25, 1]
]

list = []
counter = 0
input3.each do |item, price, quantity|
		list[counter] = Goods.new(item, (price*100).to_i, quantity)
		counter += 1
end

list.each {|x| x.receipt}
