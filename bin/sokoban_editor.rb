require_relative '../lib/graphics/window'
require_relative '../lib/graphics/renderers'
require_relative '../lib/graphics/position'
require_relative '../lib/graphics/border'
require_relative '../lib/graphics/image'
require_relative '../lib/graphics/caption'
require_relative '../lib/graphics/toolbox'
require_relative '../lib/graphics/button'
require_relative '../lib/graphics/menu'
require_relative '../lib/sokoban/load_data'

toolbox_image_paths = Sokoban.set_toolbox_image_paths
tool_box = Graphics::ToolBox.new "Tool Box", Graphics::Position.new(2, 1)
toolbox_image_paths.each { |paths| tool_box.add_tool Graphics::Image.new(paths.first, Graphics::Position.new(0, 0), 4, 4) }

menu = Graphics::Menu.new ["Test Level", "New Level", "Save Level", "Load Level"], Graphics::Position.new(2, 22)

window = Graphics::Window.new
window.draw tool_box
window.draw menu

#window.render_as(Graphics::Renderers::ShoesGUI)
puts window.render_as(Graphics::Renderers::Console)