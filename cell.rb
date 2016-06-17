class Cell
  attr_reader :row, :col
  attr_accessor :north, :south, :east, :west

  def initialize(row, col)
    @row, @col = row, col
    @links = {}
  end

  def link(cell, bidi = true)
    @links[cell] = true
    if bidi
      cell.link self, false
    end
    self
  end

  def unlink(cell, bidi = true)
    @links.delete cell
    if bidi
      cell.unlink self, false
    end
    self
  end

  def links
    @links.keys
  end

  def linked?(cell)
    @links.key?(cell)
  end

  def neighbors
    [ north, south, east, west ].compact
  end


  def coords
    "(#{row},#{col})"
  end

  def inspect
    cell_fu = ->(cell) {
      if cell.nil?
        "     " + " "
      else
        cell.coords + (linked?(cell) ? "+" : "-")
      end
    }
    "<Cell: #{coords} N: %s  E: %s  S: %s  W: %s >" % [
      cell_fu.(north),
      cell_fu.(east),
      cell_fu.(south),
      cell_fu.(west),
    ]
  end
end
