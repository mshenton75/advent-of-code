def cards
  @cards ||= File.readlines('input.txt', chomp: true)
end

Card = Struct.new(:winning_numbers, :your_numbers, keyword_init: true) do
  def score
    points = 0
    (winning_numbers & your_numbers).count.times do
      points += points.zero? ? 1 : points
    end
    points
  end
end

def parse_card(card)
  parse_nums = -> (nums) { nums.strip.split.map(&:to_i) }
  numbers = card.split(':').last.split('|')
  Card.new(winning_numbers: parse_nums.(numbers.first), your_numbers: parse_nums.(numbers.last))
end

puts(cards.map { |c| parse_card(c) }.sum(&:score))
