print "Please, input coefficient a: "
a = gets.chomp.to_f

print "Please, input coefficient b: "
b = gets.chomp.to_f

print "Please, input coefficient c: "
c = gets.chomp.to_f

discriminant = b**2 - 4*a*c

if discriminant < 0
  puts "Root not exist!"
  elsif discriminant == 0
    root = -b / 2*a
    puts "This quadratic equation has one root = #{root}."
  else
    root1 = (-b + c) / 2*a
    root2 = (-b - c) / 2*a
    puts "This quadratic equation has two roots: root1 = #{root1}, root2 = #{root2}."
end