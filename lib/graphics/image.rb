module Graphics
  class Image
    attr_reader :width, :height
    attr_accessor :file_path, :position

    def initialize(file_path, position = Position.new, width = 0, height = 0)
      @file_path = file_path
      @position  = position
      @width     = width
      @height    = height
    end

    def render_array
      [[Position.new(@position.x, @position.y), @file_path]]
    end
  end
end