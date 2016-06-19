require_relative '../colored_grid'
require_relative '../binary_tree'

grid = ColoredGrid.new(25, 25)
BinaryTree.on(grid)

start = grid[ grid.rows / 2, grid.cols / 2 ]
grid.distances = start.distances

require_relative 'util'
save_and_open_png grid

