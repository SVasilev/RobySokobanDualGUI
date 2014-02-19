module Graphics
  class Image
    attr_accessor :file_path, :position

    def initialize(file_path, position = Position.new)
      @file_path = file_path
      @position  = position
    end

    def render_array
      [[Position.new(@position.x, @position.y), @file_path]]
    end
  end
end