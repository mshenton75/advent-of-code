lines = File.readlines('input.txt')

DIGIT_MAP = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9
}.freeze

def digits(chars)
  chars.scan(/[[:digit:]]|#{DIGIT_MAP.keys.join("|")}|/).reject(&:empty?)
end

def digit_to_string(digit)
  (DIGIT_MAP[digit.to_sym] || digit).to_s
end

sum = lines.sum do |l|
  first = digits(l).first
  last = digits(l).last
  "#{digit_to_string(first)}#{digit_to_string(last)}".to_i
end

puts sum
