require 'byebug'

data = File.read('input.txt')
digits = data.chars
puts digits.zip(digits.rotate(digits.length / 2)).select { |pair| pair.first == pair.last }.map { |pair| pair.uniq.first.to_i }.sum
