require 'gosu'
require_relative 'lib/gof_cell'
require_relative 'lib/cell'
require_relative 'lib/died_cell'
require_relative 'lib/world'

class GameWindow < Gosu::Window
  def initialize
    super 800, 600, false, 500
    self.caption = 'Ojama Puyo Life'
    @background_image = Gosu::Image.new('assets/black_puyo.png', tileable: true)
    @cursor = Gosu::Image.new('assets/black_puyo.png')
    @world = World.new(43, 39)
    @cells = @world.cells
    @title_font = Gosu::Font.new(20)
    @font = Gosu::Font.new(16)
    @help = false
    @update_milliseconds = Gosu.milliseconds
    game_pause
    game_help
  end

  def update
    if game_run?
      @world.tick!
      @cells = @world.cells
    end
  end

  def needs_cursor?
    true
  end

  def draw
    draw_cells
    draw_ui
    draw_mouse
  end

  def draw_cells
    @cells.each do |cell|
      GofCell.new(cell).draw
    end
  end

  def draw_pause
    @font.draw("Pause - type 'h' to toggle help", 10, 10, 1, 1.0, 1.0, 0xffffff00) if game_paused?
  end

  def draw_help
    # 800 * 600 =>
    Gosu.draw_rect(195, 195, 410, 130, Gosu::Color.argb(0xff_ffff00), 1)
    Gosu.draw_rect(200, 200, 400, 120, Gosu::Color.argb(0xff_000000), 5)

    @title_font.draw('Help', 350, 200, 10, 1.0, 1.0, 0xffffff00)
    @font.draw('Add puyo with mouse left click', 220, 220, 10, 1.0, 1.0, 0xffffff00)
    @font.draw('Remove puyo with mouse right click', 220, 240, 10, 1.0, 1.0, 0xffffff00)
    @font.draw('Generate random puyos: \'r\'', 220, 260, 10, 1.0, 1.0, 0xffffff00)
    @font.draw('Resume game: \'space\'', 220, 280, 10, 1.0, 1.0, 0xffffff00)
    @font.draw('Quit game: \'q\'', 220, 300, 10, 1.0, 1.0, 0xffffff00)
  end

  def draw_ui
    draw_pause if game_paused?
    draw_help if game_help?
  end

  def trigger_update
    if (Gosu.milliseconds / 1000.0 > (@last_update || 0) + 1) && game_run?
      @last_update = Gosu.milliseconds / 1000.0
      true
    else
      false
    end
  end

  def draw_mouse
    cx = (mouse_x / 18).to_i * 18
    cy = (mouse_y / 15).to_i * 15
    @cursor.draw cx, cy, 0
  end

  def button_down(key)
    case key
    when Gosu::KbEscape
      game_pause
    else
      handle_keys key
    end
  end

  def handle_keys(key)
    # 'q' to quit
    if key == 4
      close
    # 'c' to clear
    elsif key == 6
      @world.cells = []
      @world.new_cells = []
    # 'r' to random
    elsif key == 21
      @world.generate_cells(30)
    elsif key == 11
      game_help
    elsif key == Gosu::KbSpace
      game_run if game_paused?
      game_help if @help
    elsif key == Gosu::MsLeft
      cx = (mouse_x / 18).to_i
      cy = (mouse_y / 15).to_i
      Cell.new(@world, cx, cy)
    elsif key == Gosu::MsRight

    end
  end

  def game_run
    @state = 'run'
  end

  def game_run?
    @state == 'run'
  end

  def game_pause
    @state = 'pause'
  end

  def game_paused?
    @state == 'pause'
  end

  def game_help
    @help = !@help
  end

  def game_help?
    @help
  end

  def game_quit
    close
  end
end

window = GameWindow.new
window.show
