vowels = Hash[(:a..:z).to_a.zip((1..26).to_a)]

vowels.select! {|litter, num| 
  litter == :a || litter == :e || litter == :i || 
  litter == :o || litter == :u || litter == :y}

vowels.each{|litter, num| puts "#{litter} - #{num}"}
