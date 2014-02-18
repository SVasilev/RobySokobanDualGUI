module Graphics
  class Menu
    def initialize(button_texts = [], position = Position.new, width = 12)
      @button_texts = button_texts
      @position = position
      @width = width
    end

    def height
      @button_texts.size * 3.3
    end

    def render_array
      render_result = []
      @button_texts.each_index { |index| render_result << Button.new(Position.new(@position.x + 1, @position.y + (index + 0.5) * 2.8), @button_texts[index]) }
      render_result.map(&:render_array).map(&:first) +
      Border.new(Position.new(@position.x, @position.y), Position.new(@position.x + @width, @position.y + height.to_i)).render_array
    end
  end
end