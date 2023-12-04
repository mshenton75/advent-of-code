def lines
  @lines ||= File.readlines('input.txt', chomp: true)
end

Number = Struct.new(:value, :start_x_coord, :y_coord, keyword_init: true) do
  def active?
    (start_x_coord...start_x_coord + value.length).to_a.each do |x_coord|
      (-1..1).each do |y|
        (-1..1).each do |x|
          return true if check_char(y_coord + y, x_coord + x)
        end
      end
    end

    false
  end

  def effective_num
    active? ? value.to_i : 0
  end
end

def check_char(y_coord, x_coord)
  char = lines[y_coord]&.[](x_coord)
  return false unless char

  char != '.' && char.match?(/[^[:digit:]]/)
end

numbers = []
lines.each_with_index do |line, i|
  line_normalized = line.gsub(/\D/, 'x').chars
  j = 0
  while j < line_normalized.length - 1
    if line_normalized[j] == 'x'
      j += 1
      next
    end

    num = ''
    start_x_coord = j
    while line_normalized[j] && line_normalized[j] != 'x'
      num << line_normalized[j]
      j += 1
    end

    numbers << Number.new(value: num, start_x_coord: start_x_coord, y_coord: i)
  end
end

puts numbers.sum(&:effective_num)
