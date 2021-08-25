# frozen_string_literal: true

print "What is your name? "
name = gets.chomp.capitalize

print "Please input your height: "
height = gets.chomp.to_f

ideal_weight = (height - 110) * 1.15
if ideal_weight >= 0
  puts "Hello, #{name}, your ideal weight is #{ideal_weight}"
else
  puts "Hello, #{name}, your weight is already optimal!"
end
