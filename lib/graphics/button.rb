module Graphics
  class Button
    def initialize(caption, position = Position.new)
      @caption  = caption
      @position = position
    end

    def render_array
      [[Position.new(@position.x, @position.y), @caption]]
    end
  end
end