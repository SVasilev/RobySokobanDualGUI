module Graphics
  class Border
    attr_reader :top_left, :bottom_right

    def initialize(top_left = Position.new, bottom_right = Position.new)
      @top_left = top_left
      @bottom_right = bottom_right
    end

    def top_right
      Position.new bottom_right.x, top_left.y
    end

    def bottom_left
      Position.new top_left.x, bottom_right.y
    end

    #Gives information about the border coordinates used in window
    def render_array
      coordinates = []
      (top_left.x..top_right.x).each { |coordinate| coordinates << [Position.new(coordinate, top_left.y)] }
      (bottom_left.x..bottom_right.x).each { |coordinate| coordinates << [Position.new(coordinate, bottom_left.y)] }
      (top_left.y + 1...bottom_left.y).each { |coordinate| coordinates << [Position.new(top_left.x, coordinate)] }
      (top_right.y + 1...bottom_right.y).each { |coordinate| coordinates << [Position.new(top_right.x, coordinate)] }
      coordinates.map { |element| element << :border }
    end
  end
end