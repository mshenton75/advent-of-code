require 'byebug'

data = File.read('input.txt')
digits = data.chars
sum = 0

digits.zip(digits.rotate(digits.length / 2)).each do |pair|
  sum += pair.first.to_i if pair.first == pair.last
end

puts sum
