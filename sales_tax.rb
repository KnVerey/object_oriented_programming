
class Goods
	attr_accessor :item, :price, :tax

	def initialize(item, price)
		@item = item
		@price = price
	end
end


input1 = {
	"book" => 12.49,
	"music" => 14.99,
	"chocolate bar" => 0.85
}

# input2 = {
# 	"imported box of chocolates" => 10.00,
# 	"imported bottle of perfume" => 47.50
# }

# input3 = {
# 	"imported bottle of perfume" => 27.99,
# 	"bottle of perfume" => 18.99,
# 	"headache pills" => 9.75,
# 	"box of imported chocolates" => 11.25
# }

list = []
counter = 0
input1.each do |item, price|
	list[counter] = Goods.new(item, price)
	counter += 1
end

puts list