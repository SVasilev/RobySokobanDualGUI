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
      end

      class << self
        def scale_x(value)
          value * SCALE_X_COEFFICIENT
        end
      end

      class << self
        def scale_y(value)
          value * SCALE_Y_COEFFICIENT
        end
      end

      class << self
        def draw_line(shoes_application, first_point, second_point)
          shoes_application.line scale_x(first_point.x), scale_y(first_point.y), scale_x(second_point.x), scale_y(second_point.y)
        end
      end

      class << self
        def extract_border_points(window)
          border_points = []
          window.height.times do |coordinate_y|
            window.width.times do |coordinate_x|
              if window.contents[[coordinate_x, coordinate_y]] == :border and window.contents[[coordinate_x + 1, coordinate_y]]
                border_points << [Position.new(coordinate_x, coordinate_y), Position.new(coordinate_x + 1, coordinate_y)]
              end
              if window.contents[[coordinate_x, coordinate_y]] == :border and window.contents[[coordinate_x, coordinate_y + 1]]
                border_points << [Position.new(coordinate_x, coordinate_y), Position.new(coordinate_x, coordinate_y + 1)]
              end
            end
          end
          border_points
        end
      end

      class << self
        def draw_borders(shoes_application, class_window)
          shoes_application.strokewidth 2
          border_points = extract_border_points class_window
          border_points.each { |point_pair| draw_line shoes_application, point_pair.first, point_pair.last }
        end
      end

      def render
        class_instance, class_window = Graphics::Renderers::ShoesGUI, @window
        Shoes.app title: "Sokoban editor", width: class_instance.scale_x(@window.width), height: class_instance.scale_y(@window.height), resizable: false do
          class_instance.draw_borders self, class_window
        end
      end
    end
  end
end