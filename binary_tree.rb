class BinaryTree
  def self.on(grid)
    grid.each_cell do |cell|
      neighbors = [ cell.north, cell.east ].compact
      neighbor = neighbors.sample
      cell.link(neighbor) if neighbor
    end

    grid
  end
end
