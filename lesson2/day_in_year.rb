print "Enter number day: "
day = gets.chomp.to_i

print "Enter number month: "
month = gets.chomp.to_i

print "Enter number year: "
year = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 30]

leap = year % 4 == 0 && year % 100 != 0 || year % 400 == 0
if leap 
  months[1] = 29
  puts "This year is leap"
end

num = 0
sum = 0

while num < month - 1
  sum += months[num]
  num += 1
end

number_day = day + sum
puts "Number this day in year is: #{number_day}"
