require 'chunky_png'

require_relative 'grid'

class ColoredGrid < Grid
  def distances=(distances)
    @distances = distances
    _, @maximum = distances.max
  end

  def background_color_for(cell)
    distance = @distances[cell] or return nil
    intensity = (@maximum - distance).to_f / @maximum
    dark = (255 * intensity).round
    bright = 128 + (127 * intensity).round
    ChunkyPNG::Color.rgb(dark, bright, dark)
  end
end
