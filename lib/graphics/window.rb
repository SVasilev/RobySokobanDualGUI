module Graphics
  class Window
    def initialize(width = 1000, height = 600)
      @width  = width
      @height = height
      @window = {}
    end

    def set_pixel(coordinate_x, coordinate_y, type)
      @window[[coordinate_x, coordinate_y]] = type if coordinate_x <= @width and coordinate_y <= @height
    end

    def pixel_type(coordinate_x, coordinate_y)
      @window[[coordinate_x, coordinate_y]]
    end

    def render_as(renderer)

    end
  end
end