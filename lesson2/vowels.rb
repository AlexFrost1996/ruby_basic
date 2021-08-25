# frozen_string_literal: true

vowels = Hash[(:a..:z).to_a.zip((1..26).to_a)]

vowels.select! { |litter, _num| %i[a e i o u y].include?(litter) }

vowels.each { |litter, num| puts "#{litter} - #{num}" }
