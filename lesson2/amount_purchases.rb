basket = {}
full_price = 0
loop do
print "Enter name of product:"
product = gets.chomp.to_s

print "Enter price of this product:"
price = gets.chomp.to_f

print "Enter amount of this product:"
amount = gets.chomp.to_f

total_price = price * amount

full_price += total_price

basket[product]={price: price , amount: amount, total_price: total_price}

print "Press any key to continue or enter stop for break..."
break if gets.chomp == "stop"
end

basket.each{|k, v| puts "#{k} => #{v}"}

puts "Full price in ticket = #{full_price}"
