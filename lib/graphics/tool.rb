module Graphics
  class Tool
    attr_reader :load_paths
    attr_accessor :image

    def initialize(image, load_paths)
      @image      = image
      @load_paths = load_paths
    end

    def render_array
      @image.render_array
    end
  end
end