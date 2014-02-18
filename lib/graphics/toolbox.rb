module Graphics
  class ToolBox
    def initialize(caption, position = Position.new, padding = 2)
      @tools = []
      @caption = caption
      @position = position
      @padding = padding
    end

    def add_tool(tool)
      @tools << tool
    end

    def width
      return 0 if @tools.empty?
      return @tools[0].width + @padding if @tools.size == 1
      2 * @padding + 2 * @tools[0].width
    end

    def height
      return 0 if @tools.empty?
      column_size = @tools.size.even? ? @tools.size / 2 : @tools.size / 2.0 + 0.5
      column_size * @padding + column_size * @tools[0].height
    end

    def arrange_images
      current_y = @position.y + 1
      @tools.each_slice(2) do |tool_slice|
        tool_slice[0].position = Position.new(@position.x + 1, current_y + @padding)
        tool_slice[1].position = Position.new(@position.x + tool_slice[0].width + @padding + 1, current_y + @padding) unless tool_slice[1] == nil
        current_y += tool_slice[0].height + 1
      end
    end

    def render_array
      arrange_images
      Caption.new(@caption, Position.new(@position.x + 2, @position.y + 1)).render_array +
      @tools.map(&:render_array).map(&:first) +
      Border.new(Position.new(@position.x, @position.y), Position.new(@position.x + width.to_i, @position.y + height.to_i)).render_array
    end
  end
end