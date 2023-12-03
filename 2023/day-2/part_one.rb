MAX_VALUES = { red: 12, green: 13, blue: 14 }.freeze

Subset = Struct.new(:red, :green, :blue, keyword_init: true) do
  def valid?
    members.all? { |color| MAX_VALUES[color] >= send(color).to_i }
  end
end

Game = Struct.new(:id, :raw_data, keyword_init: true) do
  def subsets
    raw_data.split(';').map do |subset|
      Subset.new(subset.split(',').to_h { |color_data| color_data.split.reverse })
    end
  end

  def valid?
    subsets.all?(&:valid?)
  end
end

games = File.readlines('input.txt').map do |game|
  game_data = game.split(':')
  Game.new(id: game_data.first.split.last.to_i, raw_data: game_data.last)
end

puts games.filter(&:valid?).sum(&:id)
