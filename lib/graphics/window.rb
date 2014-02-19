module Graphics
  class Window
    attr_reader :width, :height, :contents

    def initialize(width = 47, height = 29)
      @width    = width
      @height   = height
      @contents = {}
    end

    def set_pixel(coordinates, type)
      contents[[coordinates.x, coordinates.y]] = type if coordinates.x <= @width and coordinates.y <= @height
    end

    def pixel_type(coordinates)
      contents[[coordinates.x, coordinates.y]]
    end

    def draw(object)
      object.render_array.each { |coordinates_and_type| set_pixel coordinates_and_type.first, coordinates_and_type.last }
    end

    def render_as(renderer)
      renderer.new(self).render
    end

    def clear
      contents.each_key { |key| contents[key] = " " }
    end
  end
end