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
        return "E" if file_path.include? "eraser" or file_path.include? "empty"
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
        def extract_caption_points(window)
          caption_points = []
          window.contents.each_key do |key| 
            if window.contents[key].class == String and window.contents[key].size == 1
              caption_points << Position.new(key.first, key.last)
            end
          end
          caption_points
        end
      end

      class << self
        def draw_captions(shoes_application, class_window)
          captions_coordinates = extract_caption_points(class_window)
          captions_coordinates.each do |point|
             shoes_application.para shoes_application.strong(class_window.contents[[point.x, point.y]]), font: "Arial", left: scale_x(point.x).to_i, top: scale_y(point.y).to_i
          end
        end
      end

      class << self
        def extract_toolbox_pictures(window)
          toolbox_pictures_points = []
          window.contents.each_key do |key|
            if window.contents[key].class == String and window.contents[key].include? "toolbox" and
              toolbox_pictures_points << Position.new(key.first, key.last)
            end
          end
          toolbox_pictures_points
        end
      end

      class << self
        def draw_toolbox_pictures(shoes_application, class_window)
          toolbox_pictures_array, toolbox_pictures_coordinates = [], extract_toolbox_pictures(class_window)
          toolbox_pictures_coordinates.each do |point|
            toolbox_pictures_array << (shoes_application.image class_window.contents[[point.x, point.y]], left: scale_x(point.x).to_i, top: scale_y(point.y).to_i)
          end
          toolbox_pictures_array
        end
      end

      class << self
        def draw_buttons(shoes_application, class_window)
          buttons_array = []
          class_window.contents.each_key do |key| 
            if class_window.contents[key].class == String and class_window.contents[key].include? "Level"
              buttons_array << (shoes_application.button(class_window.contents[key]).style width: 116, height: 30, left: scale_x(key.first).to_i, top: scale_y(key.last).to_i)
            end
          end
          buttons_array
        end
      end

      class << self
        def button_event(button, ground_pictures, picture_indexes, picture_paths, shoes_application)
          case button.style[:text]
          when "Test Level"
            if propriety_check(picture_indexes) == ""
              #Sokoban.game ground.picture_indexes
            else
              shoes_application.alert propriety_check(picture_indexes)
            end
          when "New Level"
            if shoes_application.confirm("Are you sure you want to start new level? All data for this level will be lost.")
              ground_clear(ground_pictures, picture_indexes, picture_paths)
            end
          when "Save Level"
            if propriety_check(picture_indexes) == ""
              file = shoes_application.ask_save_file
              File.open(file, "w+") { |file| file.write picture_indexes }
            else
              shoes_application.alert propriety_check(picture_indexes)
            end
          when "Load Level"
            if shoes_application.confirm("Are you sure you want to load new level? All data for this level will be lost.")
              file, coordinates = shoes_application.ask_open_file, []
              file_information = File.read(file)
              file_information.each_char { |charecter| coordinates << charecter.to_i if ["0", "1", "2", "3", "4"].include?(charecter) }
              ground_clear(ground_pictures, picture_indexes, picture_paths)
              coordinates.each_index do |index|
                picture_index_change ground_pictures, picture_indexes, picture_paths, index, coordinates[index]
              end
            end
          end
        end
      end

      class << self
        def extract_ground_pictures(window)
          ground_pictures_array = []
          window.contents.each_key do |key|
            if window.contents[key].class == String and window.contents[key].include? "normal_elements"
               ground_pictures_array << Position.new(key.first, key.last)
            end
          end
          ground_pictures_array
        end
      end

      class << self
        def draw_ground_pictures(shoes_application, class_window)
          ground_pictures_array, ground_pictures_coordinates = [], extract_ground_pictures(class_window)
          ground_pictures_coordinates.each do |point|
             ground_pictures_array << (shoes_application.image class_window.contents[[point.x, point.y]], left: scale_x(point.x).to_i, top: scale_y(point.y).to_i)
          end
          ground_pictures_array
        end
      end
      
      class << self
        def ground_hover?(ground_pictures, mouse_left, mouse_top)
          mouse_left > ground_pictures[0].style[:left] and mouse_top > ground_pictures[0].style[:top] and
          mouse_left < ground_pictures.last.style[:left] + ground_pictures[0].full_width and 
          mouse_top  < ground_pictures.last.style[:top]  + ground_pictures[0].full_height
        end
      end

      class << self
        def picture_hover?(index, mouse_left, mouse_top, ground_pictures)
          mouse_left > ground_pictures[index].style[:left] and mouse_top > ground_pictures[index].style[:top] and
          mouse_left < ground_pictures[index].style[:left] + ground_pictures[index].full_width and
          mouse_top  < ground_pictures[index].style[:top]  + ground_pictures[index].full_height
        end
      end

      class << self
        def picture_index_at(mouse_left, mouse_top, ground_pictures)
          ground_pictures.each_index { |index| return index if picture_hover? index, mouse_left, mouse_top, ground_pictures }
        end
      end

      class << self
        def ground_update(mouse_left, mouse_top, ground_pictures, picture_indexes, picture_paths, clicked_tool)
          #Check if there is already a start position
          if picture_indexes.include? 3 and clicked_tool == 3
            picture_indexes = picture_index_change ground_pictures, picture_indexes, picture_paths, picture_indexes.index(3), 4
          end
          picture_index_change ground_pictures, picture_indexes, picture_paths, picture_index_at(mouse_left, mouse_top, ground_pictures), clicked_tool
        end
      end

      class << self
        def picture_index_change(ground_pictures, picture_indexes, picture_paths, index, value)
          ground_pictures[index].path = picture_paths[value]
          picture_indexes[index] = value
          picture_indexes
        end
      end

      class << self
        def ground_clear(ground_pictures, picture_indexes, picture_paths)
          ground_pictures.each_index { |index| picture_index_change ground_pictures, picture_indexes, picture_paths, index, 4 }
        end
      end

      class << self
        def propriety_check(picture_indexes)
          warnings = ""
          warnings << "The level doesn't have a start." unless picture_indexes.include? 3
          warnings << " Cubes don't match the finals count." unless picture_indexes.count(1) == picture_indexes.count(2)
          warnings << " There are no cubes." if picture_indexes.count(1) == 0
          warnings << " The level is already solved." if picture_indexes.all? { |element| element != 1 } and warnings == ""
          warnings
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
          clicked_tool = 0
          toolbox_pictures.each_index do |index| 
            toolbox_pictures[index].click do
              toolbox_pictures[index].path = toolbox_image_paths[index].last
              toolbox_pictures[clicked_tool].path = toolbox_image_paths[clicked_tool].first
              clicked_tool = index
            end
          end

          #Catch ground drawing events
          ground_pictures = class_instance.draw_ground_pictures self, class_window
          picture_indexes = ground_pictures.map { 4 }
          picture_paths   = Sokoban.set_ground_image_paths
          mouse_down      = false

          click { |button, left, top| mouse_down = true if button == 1 and class_instance.ground_hover? ground_pictures, left, top }
          
          release do |button, left, top|
            if button == 1 and class_instance.ground_hover? ground_pictures, left, top
              picture_indexes = class_instance.ground_update left, top, ground_pictures, picture_indexes, picture_paths, clicked_tool
              mouse_down = false
            end
          end

          motion do |left, top| 
            if mouse_down and class_instance.ground_hover? ground_pictures, left, top
              picture_indexes = class_instance.ground_update left, top, ground_pictures, picture_indexes, picture_paths, clicked_tool
            end
          end

          #Catch buttons click events
          buttons_array = class_instance.draw_buttons self, class_window
          buttons_array.each { |button| button.click { class_instance.button_event button, ground_pictures, picture_indexes, picture_paths, self } }
        end
      end
    end
  end
end