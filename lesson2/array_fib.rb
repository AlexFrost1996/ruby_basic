array_fib = [0, 1]
loop do
  next_fib = array_fib[-1] + array_fib[-2]
  array_fib << next_fib
  break if next_fib >= 100
end

puts "#{array_fib}"