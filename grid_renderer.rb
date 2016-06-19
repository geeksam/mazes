require 'virtus'

module GridRenderer

  class ASCII
    include Virtus.model
    attribute :grid

    def self.call(grid)
      new(grid: grid).print
    end

    def print
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

end
