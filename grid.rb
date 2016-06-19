require_relative 'cell'
require_relative 'grid_renderer'
require 'pp'

class Grid
  attr_reader :rows, :cols

  def initialize(rows, cols)
    @rows, @cols = rows, cols
    @grid = prepare_grid
    configure_cells
  end

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(row, col)
      end
    end
  end

  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.col

      cell.north = self[ row - 1, col     ]
      cell.east  = self[ row,     col + 1 ]
      cell.south = self[ row + 1, col     ]
      cell.west  = self[ row,     col - 1 ]
    end
  end

  def [](row, col)
    return nil unless row.between?(0, @rows - 1)
    return nil unless col.between?(0, @cols - 1)
    @grid[row][col]
  end

  def random_cell
    row = rand(@rows)
    col = rand(@grid[row].length)
    self[ row, col ]
  end

  def size
    @rows * @cols
  end

  def each_row
    @grid.each do |row|
      yield row
    end
  end

  def each_cell
    each_row do |row|
      row.each do |cell|
        if cell
          yield cell
        end
      end
    end
  end

  def to_s
    GridRenderer::ASCII.call(self)
  end

  def to_png(cell_size: 10)
    GridRenderer::PNG.call(self)
  end

  def contents_of(cell)
    " "
  end

  def background_color_for(cell)
    nil
  end

end
