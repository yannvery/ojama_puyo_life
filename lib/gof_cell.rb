class GofCell
  def initialize(cell)
    @image = Gosu::Image.new('assets/black_puyo.png')
    dimx = 18
    dimy = 15
    @x = cell.x * dimx
    @y = cell.y * dimy
    @angle = 0.0
  end

  def draw
    @image.draw(@x, @y, @angle)
  end
end
