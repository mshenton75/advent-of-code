lines = File.readlines('input.txt')

def first_digit(chars)
  chars[/[[:digit:]]/]
end

sum = lines.sum do |l|
  first = first_digit(l)
  last = first_digit(l.reverse)

  "#{first}#{last}".to_i
end

puts sum
