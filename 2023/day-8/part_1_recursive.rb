require 'byebug'

def lines
  @lines ||= File.readlines('input.txt', chomp: true)
end

def directions
  @directions ||= lines.first.chars.map { |d| d == 'R' ? 'right' : 'left' }
end

Node = Struct.new(:id, :left, :right, keyword_init: true)

def network
  @network ||= lines.drop(2).to_h { |l| parse_line(l) }
end

def parse_line(line)
  line_arr = line.split(' = ')
  id = line_arr.first
  left, right = line_arr.last.slice(1...-1).split(',')
  [id, Node.new(id: id, left: left.strip, right: right.strip)]
end

def next_node(id:, direction:, count:)
  return count if id == 'ZZZ'

  node = network[id]
  count += 1
  next_node(id: node.send(direction), direction: directions[count % directions.length], count: count)
end

def navigate_network
  next_node(id: "AAA", direction: directions.first, count: 0)
end

puts navigate_network
