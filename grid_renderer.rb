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

          body = "   "
          lnk_east = cell.linked?(cell.east)
          east_boundary = (lnk_east ? " " : "|")
          top << body << east_boundary

          lnk_south = cell.linked?(cell.south)
          south_boundary = (lnk_south ? "   " : "---")
          corner = "+"
          bottom << south_boundary << corner
        end

        output << top << "\n"
        output << bottom << "\n"
      end

      output
    end
  end

end
