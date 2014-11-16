class World

  def initialize
    @cells = Hash.new(nil)
  end

  def add_cell x, y
    @cells[[x, y]] = :live
  end

  def delete_cell x, y
    @cells.delete([x, y])
  end

  def map_neighbors
    neighbors = Hash.new(0)

    @cells.each do |k, v|
      row, col = k

      (-1..1).to_a.repeated_permutation(2).to_a.each do |row_offset, col_offset|
        neighbors[[row + row_offset, col + col_offset]] += 1
      end

      neighbors[[row, col]] -= 1
    end

    return neighbors
  end

  def run
    neighbors = map_neighbors

    neighbors.each do |coordinates, count|
      row, col = coordinates
      add_cell(row, col) if count == 3
      delete_cell(row, col) if count < 2 || count > 3
    end

    system("clear")
    puts self
    puts @cells.size
    sleep(0.1)
  end

  def to_s
    neighbors = map_neighbors
    string = ""
    (-10..29).each do |r|
      string << (-10..29).to_a.map{|c| ((@cells[[r,c]] != nil) ? "X" : " ")}.join + "\n"
    end
    return string
  end

end


world = World.new

200.times do
  world.add_cell(rand(20), rand(20))
end

loop do
  world.run
end