module Graphics
  class Ground
    attr_reader :width, :height
    def initialize(picture = "", position = Position.new(15, 2), width = 30, height = 25)
      @picture  = picture
      @position = position
      @width    = width
      @height   = height
    end

    def render_array
      render_result = Border.new(Position.new(@position.x - 1, @position.y - 1), Position.new(@position.x + @width + 1, @position.y + @height + 1)).render_array
      @height.times do |y_coordinate| 
        @width.times do |x_coordinate| 
          render_result += Image.new(@picture, Position.new(@position.x + x_coordinate, @position.y + y_coordinate)).render_array
        end
      end
      render_result
    end
  end
end