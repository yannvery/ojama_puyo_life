class World
  attr_accessor :cells
  attr_accessor :new_cells
  attr_accessor :died_cells
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y)
    @cells = []
    @new_cells = []
    @died_cells = []
    @x = x
    @y = y
  end

  def tick!
    refresh_died_cells
    @died_cells ||= []
    died_cells.each do |cell|
      cell.born! if cell.neighbours.count == 3
    end
    cells.each do |cell|
      if cell.neighbours.count < 2
        cell.die!
      elsif cell.neighbours.count == 2 || cell.neighbours.count == 3
        cell.live!
      elsif cell.neighbours.count > 3
        cell.die!
      end
    end
    @cells = @new_cells.uniq { |e| [e.x, e.y] }.reject do |cell|
      cell.x < 0 || cell.y < 0 || cell.x > x || cell.y > y
    end
  end

  def refresh_died_cells
    @died_cells = []
    cells.each do |cell|
      @died_cells << cell.died_neighbours
    end
    @died_cells = @died_cells.flatten!
    @died_cells = @died_cells.uniq { |e| [e.x, e.y] } if @died_cells
  end

  def cell_exists?(x, y)
    cells.each do |cell|
      return true if cell.x == x && cell.y == y
    end
    false
  end

  def generate_cells(percent)
    max_cells = x * y
    cells_number = (max_cells * percent) / 100
    generate_cell while cells.count < cells_number
  end

  def generate_cell
    Cell.new(self, rand(x), rand(y))
  end
end
