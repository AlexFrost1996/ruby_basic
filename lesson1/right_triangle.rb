print "Please input first sife of a triangle: "
first_side = gets.to_f

print "Please input second sife of a triangle: "
second_side = gets.to_f

print "Please input third sife of a triangle: "
third_side = gets.to_f

array = [first_side, second_side, third_side]
sort_array = array.sort {|x,y| x <=> y}
hipotenuze = sort_array[2]
katet1 = sort_array[1]
katet2 = sort_array[0]

if hipotenuze**2 == katet1**2 + katet2**2 && katet1 == katet2
  puts "This triangle is right and isosceles"
  elsif hipotenuze**2 == katet1**2 + katet2**2
    puts "This triangle is right"
    elsif katet1 == katet2 && katet1 == hipotenuze
      puts "This triangle is isoceles and equilateral"
      elsif katet1 == katet2
        puts "This triangle is isoceles"
        else
          puts "This triangle has no equal sides or right angle" 
end