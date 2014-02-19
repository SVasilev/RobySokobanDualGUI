module Graphics
  class Ground
    def initialize(picture = "", position = Position.new(15, 2), width = 30, height = 25)
      @picture  = picture
      @position = position
      @width    = width
      @height   = height
    end

    def render_array
      render_result = Border.new(Position.new(@position.x - 1, @position.y - 1), Position.new(@position.x + @width + 1, @position.y + @height + 1)).render_array
      @height.times do |y_coordinate| 
        @width.times do |x_coordinate| 
          render_result += Image.new(@picture, Position.new(@position.x + x_coordinate, @position.y + y_coordinate)).render_array
        end
      end
      render_result
    end

    def propriety_check
      warnings = ""
      warnings << "The level doesn't have a start." unless @picture_indexes.include? [3] or @picture_indexes.include? [2, 3]
      if (@picture_indexes.count([1]) != @picture_indexes.count([2]) and @picture_indexes.include?([2, 3]) == false) or
         ((@picture_indexes.count([1]) - 1) != @picture_indexes.count([2]) and @picture_indexes.include? [2, 3])
        warnings << " Cubes don't match the finals count."
      end
      warnings << " There are no cubes." if @picture_indexes.count([1]) == 0 and @picture_indexes.count([1, 2]) == 0
      warnings << " The level is already solved." if @picture_indexes.all? { |element| element != [1] } and warnings == ""
      warnings
    end

    def clear
      @pictures.each_index { |index| picture_index_change index, 4 }
    end
  end
end