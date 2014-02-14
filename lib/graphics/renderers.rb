module Graphics
  class Renderers
    class Console
      def initialize(window)
        @window = window
      end

      def render
        rendered_string = ""
        @window.height.times do |coordinate_y|
          @window.width.times do |coordinate_x|
            case @window.contents[[coordinate_x, coordinate_y]]
            when :border
              rendered_string << "."
            else 
              rendered_string << " "
            end
          end
          rendered_string << "\n"
        end
        rendered_string
      end
    end

    class ShoesGUI
      SCALE_X_COEFFICIENT, SCALE_Y_COEFFICIENT = 12.65, 15

      def initialize(window)
        @window = window
        #@window_array = scale_coordinates window.contents.to_a
      end

      def scale_x(value)
        value * SCALE_X_COEFFICIENT
      end

      def scale_y(value)
        value * SCALE_Y_COEFFICIENT
      end

      def scale_coordinates(window)
        scaled_array = []
        window.each { |element| scaled_array << [[scale_x(element.first.first), scale_y(element.first.last)], element.last] }
        scaled_array
      end

      def extract_border_points
        border_points = []
        @window.height.times do |coordinate_y|
          @window.width.times do |coordinate_x|
            if @window.contents[[coordinate_x, coordinate_y]] == :border and @window.contents[[coordinate_x + 1, coordinate_y]]
              border_points << [Position.new(coordinate_x, coordinate_y), Position.new(coordinate_x + 1, coordinate_y)]
            end
          end
        end
        border_points
      end

      def self.draw_line(shoes_application, first_point, second_point)
        p :alive
        shoes_application.line scale_x(first_point.x), scale_y(first_point.y), scale_x(second_point.x), scale_y(second_point.y)
      end

      def render
        border_points = extract_border_points
        Shoes.app title: "Sokoban editor", width: scale_x(@window.width), height: scale_y(@window.height), resizable: false do
          p border_points
          border_points.each { |point_pair| line scale_x(point_pair.first.x), scale_y(point_pair.first.y), scale_x(point_pair.last.x), scale_y(point_pair.last.y) }
          p :Alive
        end
      end
    end
  end
end