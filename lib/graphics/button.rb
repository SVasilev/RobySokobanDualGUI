module Graphics
  class Button
    def initialize(position = Position.new, caption)
      @position = position
      @caption  = caption
    end

    def render_array
      [[Position.new(@position.x, @position.y), @caption]]
    end
  end
end