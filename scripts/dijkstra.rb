require_relative '../distance_grid'
require_relative '../binary_tree'

grid = DistanceGrid.new(5, 5)
BinaryTree.on(grid)

start = grid[0,0]
distances = start.distances

grid.distances = distances
puts grid

puts "\npath from NW to SW:"
goal = grid[grid.rows - 1, 0]
grid.distances = distances.path_to(goal)
puts grid
