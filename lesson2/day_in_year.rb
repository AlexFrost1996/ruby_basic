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

number_day = months.take(month-1).sum + day
puts "Number this day in year is: #{number_day}"
