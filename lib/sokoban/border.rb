module Sokoban
  class Border
    attr_reader :padding

    def initialize(top_left = Position.new, bottom_right = Position.new, padding = 0, color = "AAA", width = 2)
      @top_left = top_left
      @bottom_right = bottom_right
      @padding = padding
      @color = color
      @width = width
    end

    def top_right
      Position.new @bottom_right.x, @top_left.y
    end

    def bottom_left
      Position.new @top_left.x, @bottom_right.y
    end
  end
end