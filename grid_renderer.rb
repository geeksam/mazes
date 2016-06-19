require 'virtus'
require 'chunky_png'

module GridRenderer

  class Base
    include Virtus.model
    attribute :grid

    def self.call(grid)
      new(grid: grid).render
    end
  end

  class ASCII < Base
    def render
      output = "+" + "---+" * grid.cols + "\n"

      grid.each_row do |row|
        top = "|"
        bottom = "+"

        row.each do |cell|
          cell = Cell.new(-1, -1) unless cell
          top    << east_boundary(cell)
          bottom << south_boundary(cell)
        end

        output << top << "\n"
        output << bottom << "\n"
      end

      output
    end

    private

    def east_boundary(cell)
      body = " %s " % grid.contents_of(cell)
      lnk_east = cell.linked?(cell.east)
      east_boundary = (lnk_east ? " " : "|")
      body + east_boundary
    end

    def south_boundary(cell)
      lnk_south = cell.linked?(cell.south)
      south_boundary = (lnk_south ? "   " : "---")
      corner = "+"
      south_boundary + corner
    end
  end

  class PNG < Base
    def render(cell_size: 25)
      img_width  = cell_size * grid.cols
      img_height = cell_size * grid.rows

      background = ChunkyPNG::Color::WHITE
      wall = ChunkyPNG::Color::BLACK

      img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)

      grid.each_cell do |cell|
        [:backgrounds, :walls].each do |mode|
          x1 = cell.col * cell_size
          y1 = cell.row * cell_size
          x2 = (cell.col + 1) * cell_size
          y2 = (cell.row + 1) * cell_size

          if mode == :backgrounds
            color = grid.background_color_for(cell)
            padding = 10
            img.rect(x1+padding, y1+padding, x2-padding, y2-padding, color, color) if color
          else
            img.line(x1, y1, x2, y1, wall) unless cell.north
            img.line(x1, y1, x1, y2, wall) unless cell.west
            img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
            img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south)
          end
        end
      end

      img
    end
  end

end
