require_relative '../sokoban/load_data'

module Graphics
  class Renderers
    class Console
      def initialize(window)
        @window = window
      end

      def image_sign(file_path)
        return "W" if file_path.include? "wall"
        return "C" if file_path.include? "cube"
        return "F" if file_path.include? "final"
        return "S" if file_path.include? "smiley"
        return "E" if file_path.include? "eraser"
        "B"
      end

      def render
        rendered_string = ""
        @window.height.times do |coordinate_y|
          @window.width.times do |coordinate_x|
            content = @window.contents[[coordinate_x, coordinate_y]]
            case content.class.to_s
            when "Symbol"
              rendered_string << "."
            when "String"
              rendered_string << (content.size > 1 ? image_sign(content) : content)
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
              if window.contents[[coordinate_x, coordinate_y]] == :border and window.contents[[coordinate_x + 1, coordinate_y]] == :border
                border_points << [Position.new(coordinate_x, coordinate_y), Position.new(coordinate_x + 1, coordinate_y)]
              end
              if window.contents[[coordinate_x, coordinate_y]] == :border and window.contents[[coordinate_x, coordinate_y + 1]] == :border
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
          shoes_application.stroke "AAA"
          border_points = extract_border_points class_window
          border_points.each { |point_pair| draw_line shoes_application, point_pair.first, point_pair.last }
        end
      end

      class << self
        def draw_toolbox_pictures(shoes_application, class_window)
          toolbox_pictures_array = []
          class_window.contents.each_key do |key| 
            if class_window.contents[key].class == String and class_window.contents[key].include? "toolbox"
              toolbox_pictures_array << (shoes_application.image class_window.contents[key], left: scale_x(key.first).to_i, top: scale_y(key.last).to_i)
            end
          end
          toolbox_pictures_array
        end
      end

      class << self
        def draw_ground_pictures(shoes_application, class_window)
          ground_pictures_array = []
          class_window.contents.each_key do |key| 
            if class_window.contents[key].class == String and class_window.contents[key].include? "normal_elements"
              ground_pictures_array << (shoes_application.image class_window.contents[key], left: scale_x(key.first).to_i, top: scale_y(key.last).to_i)
            end
          end
          ground_pictures_array
        end
      end

      class << self
        def draw_captions(shoes_application, class_window)
          class_window.contents.each_key do |key| 
            if class_window.contents[key].class == String and class_window.contents[key].size == 1
              shoes_application.para shoes_application.strong(class_window.contents[key]), font: "Arial", left: scale_x(key.first).to_i, top: scale_y(key.last).to_i
            end
          end
        end
      end

      class << self
        def toolbox_click(shoes_application, toolbox_pictures, toolbox_image_paths, clicked_tool)
          toolbox_pictures.each_index do |index| 
            toolbox_pictures[index].click do
              toolbox_pictures[index].path = toolbox_image_paths[index].last
              toolbox_pictures[clicked_tool].path = toolbox_image_paths[clicked_tool].first
              clicked_tool = index
            end
          end
        end
      end

      class << self
        def draw_buttons(shoes_application, class_window)
          buttons_array = []
          class_window.contents.each_key do |key| 
            if class_window.contents[key].class == String and class_window.contents[key].include? "Level"
              buttons_array << (shoes_application.button(class_window.contents[key]).style width: 126, height: 38, left: scale_x(key.first).to_i, top: scale_y(key.last).to_i)
            end
          end
          buttons_array
        end
      end

      def render
        class_instance, class_window = Graphics::Renderers::ShoesGUI, @window

        Shoes.app title: "Sokoban editor", width: class_instance.scale_x(@window.width), height: class_instance.scale_y(@window.height), resizable: false do
          class_instance.draw_borders self, class_window
          class_instance.draw_captions self, class_window

          #Catch toolbox click events
          toolbox_pictures = class_instance.draw_toolbox_pictures self, class_window
          toolbox_image_paths = Sokoban.set_toolbox_image_paths
          toolbox_pictures[0].path = toolbox_image_paths[0].last
          class_instance.toolbox_click self, toolbox_pictures, toolbox_image_paths, 0

          #Catch buttons click events
          buttons_array = class_instance.draw_buttons self, class_window
          buttons_array.each { |button| button.click { p :pradnq } }

          #Catch ground drawing events
          ground_images = class_instance.draw_ground_pictures self, class_window
        end
      end
    end
  end
end