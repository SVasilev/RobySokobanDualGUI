module Graphics
  class Caption
    def initialize(string, position)
      @string   = string
      @position = position
    end

    def render_array
      render_result = []
      @string.size.times { |index| render_result << [Position.new(@position.x + index, @position.y), @string[index]] }
      render_result
    end
  end
end