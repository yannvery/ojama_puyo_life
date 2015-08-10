class DiedCell
  attr_accessor :world, :x, :y

  def initialize(world, x = 0, y = 0)
    @world = world
    @x = x
    @y = y
  end

  def neighbours
    @neighbours = Set.new
    world.cells.each do |cell|
      # Has a cell to the north
      @neighbours.add cell if x == cell.x && y == cell.y - 1

      # Has a cell to the south
      @neighbours.add cell if x == cell.x && y == cell.y + 1

      # Has a cell to the north east
      @neighbours.add cell if x == cell.x - 1 && y == cell.y - 1

      # Has a cell to the north west
      @neighbours.add cell if x == cell.x + 1 && y == cell.y - 1

      # Has a cell to the south west
      @neighbours.add cell if x == cell.x + 1 && y == cell.y + 1

      # Has a cell to the south east
      @neighbours.add cell if x == cell.x - 1 && y == cell.y + 1

      # Has a cell to the east
      @neighbours.add cell if x == cell.x - 1 && y == cell.y

      # Has a cell to the west
      @neighbours.add cell if x == cell.x + 1 && y == cell.y
    end
    @neighbours
  end

  def born!
    cell = Cell.new world, x, y
    cell.born!
  end

  def eql?(other_cell)
    x == other_cell.x && y == other_cell.y && self.class == other_cell.class
  end
end
