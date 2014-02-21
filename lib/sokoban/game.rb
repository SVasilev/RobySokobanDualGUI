module Sokoban
  class << self
    def game(renderer, level_path)
      require_relative 'load_data'
      Sokoban.require_files

      #Load level data
      level = []
      if level_path.respond_to? :intern
        file_information = File.read(level_path)
        file_information.each_char { |charecter| level << charecter.to_i if ["0", "1", "2", "3", "4"].include?(charecter) }
      else
        level = level_path
      end

      ground = Graphics::Ground.new "../img/normal_elements/nothing.gif", Graphics::Position.new(2, 2)
      window = Graphics::Window.new 34
      start_position, finals = Graphics::Position.new(level.index(3) % ground.width, level.index(3) / ground.width), {}
      level.each_index { |index| finals[[index % ground.width, index.div(ground.width)]] = true if level[index] == 2 } 
      picture_paths = Sokoban.set_ground_image_paths
      player = Graphics::Player.new window, "../img/normal_elements/smiley.gif", finals, picture_paths, start_position
      window.draw ground
      level.each_index { |index| window.contents[[index % ground.width, index.div(ground.width)]] = picture_paths[level[index]] unless level[index] == 4 }
      window.draw player

      if renderer == Graphics::Renderers::ShoesGUI
        window.render_as(renderer)
      else
        while(window.contents.values.any? { |value| value.class == String and value.include?("final") } or player.finals.keys.include?([player.position.x, player.position.y]))
          window.render_as(renderer)
          puts "Legend: # - Wall, o - Cube, x - Final, @ - Player\nCommands a - left, d - right, w - up, s - down, q - quit"
          input = STDIN.gets
          case input
          when "a\n"
            window = player.move(:left)
          when "d\n"
            window = player.move(:right)
          when "w\n"
            window = player.move(:up)
          when "s\n"
            window = player.move(:down)
          when "q\n"
            puts "Are you sure you want to quit? (y/n)"
            choice = STDIN.gets
            choice == "y\n" ? break : loop
          end
        end
        puts "Congratulations! You've completed the level." unless window.contents.values.any? { |value| value.class == String and value.include?("final") } or player.finals.keys.include? [player.position.x, player.position.y]
      end
    end
  end
end