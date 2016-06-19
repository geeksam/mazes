def save_and_open_png(grid)
  img = grid.to_png
  calling_file = caller.first.split(".").first
  filename = "tmp/%s.png" % File.basename( calling_file )
  img.save filename
  puts filename
  `open #{filename}`
end
