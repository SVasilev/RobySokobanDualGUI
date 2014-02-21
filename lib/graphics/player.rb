module Graphics
  class Player
    attr_reader :load_picture, :finals, :picture_paths, :position
    attr_accessor :window

    def initialize(window, load_picture, finals, picture_paths, position)
      @window = window
      @load_picture = load_picture
      @finals = finals
      @picture_paths = picture_paths
      @position = position
    end

    def valid_move?(displacement, direction)
      next_element = direction == :horizontal ? @window.contents[[@position.x + displacement, @position.y]] : @window.contents[[@position.x, @position.y + displacement]]
      after_next   = direction == :horizontal ? @window.contents[[@position.x + 2 * displacement, @position.y]] : @window.contents[[@position.x, @position.y + 2 * displacement]]
      return false if (next_element.class == String and next_element.include?("wall")) or next_element.class == Symbol or
                      ((next_element.class == String and next_element.include?("cube")) and 
                      ((after_next.class == String and (after_next.include?("wall") or after_next.include?("cube"))) or after_next.class == Symbol))
      true
    end

    def push_cube_horizontal(displacement)
      if @window.contents[[@position.x + displacement, @position.y]].include? "cube"
        @window.contents[[@position.x + displacement * 2, @position.y]] = @picture_paths[1] 
      end
    end

    def push_cube_vertical(displacement)
      if @window.contents[[@position.x, @position.y + displacement]].include? "cube"
        @window.contents[[@position.x, @position.y + displacement * 2]] = @picture_paths[1] 
      end
    end

    def move(direction)
      case direction
      when :left
        if valid_move?(-1, :horizontal)
          @window.contents[[@position.x, @position.y]] = (@finals[[@position.x, @position.y]] != nil) ? @picture_paths[2] : @picture_paths[4]
          push_cube_horizontal -1
          @window.contents[[@position.x - 1, @position.y]] = @load_picture
          @position = Position.new(@position.x - 1, @position.y)
        end
      when :right
        if valid_move?(+1, :horizontal)
          @window.contents[[@position.x, @position.y]] = (@finals[[@position.x, @position.y]] != nil) ? @picture_paths[2] : @picture_paths[4]
          push_cube_horizontal +1
          @window.contents[[@position.x + 1, @position.y]] = @load_picture
          @position = Position.new(@position.x + 1, @position.y)
        end
      when :up
        if valid_move?(-1, :vertical)
          @window.contents[[@position.x, @position.y]] = (@finals[[@position.x, @position.y]] != nil) ? @picture_paths[2] : @picture_paths[4]
          push_cube_vertical -1
          @window.contents[[@position.x, @position.y - 1]] = @load_picture
          @position = Position.new(@position.x, @position.y - 1)
        end
      when :down
        if valid_move?(+1, :vertical)
          @window.contents[[@position.x, @position.y]] = (@finals[[@position.x, @position.y]] != nil) ? @picture_paths[2] : @picture_paths[4]
          push_cube_vertical +1
          @window.contents[[@position.x, @position.y + 1]] = @load_picture
          @position = Position.new(@position.x, @position.y + 1)
        end
      end
      return @window
    end

    def render_array
      [[Position.new(@position.x, @position.y), @load_picture]]
    end
  end
end