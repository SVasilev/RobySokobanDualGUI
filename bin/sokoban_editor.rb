require_relative '../lib/sokoban/load_data'
Sokoban.require_files


toolbox_image_paths = Sokoban.set_toolbox_image_paths
tool_box = Graphics::ToolBox.new "Tool Box", Graphics::Position.new(1, 1)
toolbox_image_paths.each { |paths| tool_box.add_tool Graphics::Image.new(paths.first, Graphics::Position.new(0, 0)) }

menu = Graphics::Menu.new ["Test Level", "New Level", "Save Level", "Load Level"], Graphics::Position.new(1, 18)

ground = Graphics::Ground.new "../img/normal_elements/empty.gif"

window = Graphics::Window.new
window.draw tool_box
window.draw menu
window.draw ground
#p window.contents


window.render_as(Graphics::Renderers::ShoesGUI)
#puts window.render_as(Graphics::Renderers::Console)