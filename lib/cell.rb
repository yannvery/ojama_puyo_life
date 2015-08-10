require 'set'

class Cell
  attr_accessor :world, :x, :y

  def initialize(world, x = 0, y = 0)
    @world = world
    @x = x
    @y = y
    world.cells << self
  end

  def neighbours
    @neighbours = Set.new
    world.cells.each do |cell|
      # Has a cell to the north
      @neighbours.add cell if x == cell.x && y == cell.y - 1

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

  def died_neighbours
    died_neighbours = []
    died_neighbours << DiedCell.new(world, x - 1, y) unless world.cell_exists?(x - 1, y)
    died_neighbours << DiedCell.new(world, x + 1, y) unless world.cell_exists?(x + 1, y)
    died_neighbours << DiedCell.new(world, x, y - 1) unless world.cell_exists?(x, y - 1)
    died_neighbours << DiedCell.new(world, x, y + 1) unless world.cell_exists?(x, y + 1)
    died_neighbours << DiedCell.new(world, x - 1, y - 1) unless world.cell_exists?(x - 1, y - 1)
    died_neighbours << DiedCell.new(world, x + 1, y - 1) unless world.cell_exists?(x + 1, y - 1)
    died_neighbours << DiedCell.new(world, x - 1, y + 1) unless world.cell_exists?(x - 1, y + 1)
    died_neighbours << DiedCell.new(world, x + 1, y + 1) unless world.cell_exists?(x + 1, y + 1)
    died_neighbours
  end

  def spawn_at(x, y)
    Cell.new(@world, x, y)
  end

  def die!
    world.new_cells -= [self]
  end

  def dead?
    !world.cells.include?(self)
  end

  def live!
    world.new_cells += [self]
  end

  def alive?
    world.cells.include?(self)
  end

  def born!
    world.cells -= [self]
    world.new_cells += [self]
  end

  def eql?(other_cell)
    x == other_cell.x && y == other_cell.y && self.class == other_cell.class
  end

end
