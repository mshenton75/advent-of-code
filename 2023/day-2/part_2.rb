Subset = Struct.new(:red, :green, :blue, keyword_init: true)

Game = Struct.new(:id, :raw_data, keyword_init: true) do
  def subsets
    raw_data.split(';').map do |subset|
      Subset.new(subset.split(',').to_h { |color_data| color_data.split.reverse })
    end
  end

  def power
    Subset.members.reduce(1) { |product, member| subsets.map { |subset| subset.send(member).to_i }.max * product }
  end
end

games = File.readlines('input.txt').map do |game|
  game_data = game.split(':')
  Game.new(id: game_data.first.split.last.to_i, raw_data: game_data.last)
end

puts games.sum(&:power)
