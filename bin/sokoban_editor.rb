require_relative '../lib/graphics/window'
require_relative '../lib/graphics/renderers'
require_relative '../lib/graphics/position'
require_relative '../lib/graphics/border'
require_relative '../lib/graphics/image'
require_relative '../lib/graphics/caption'
require_relative '../lib/graphics/tool'
require_relative '../lib/graphics/toolbox'

require_relative '../lib/sokoban/load_data'

toolbox_image_paths = Sokoban.set_toolbox_image_paths
tool_box = Graphics::ToolBox.new "Tool Box", Graphics::Position.new(2, 1)
toolbox_image_paths.each { |paths| tool_box.add_tool Graphics::Tool.new(Graphics::Image.new(paths.first, Graphics::Position.new(0, 0), 4, 4), paths) }

#border = Graphics::Border.new Graphics::Position.new(1, 1), Graphics::Position.new(10, 10)
#border1 = Graphics::Border.new Graphics::Position.new(20, 10), Graphics::Position.new(30, 20)
#image = Graphics::Image.new "../img/toolbox_normal/cube.gif", Graphics::Position.new(50, 30), 5, 5
#caption = Graphics::Caption.new "Tool Box", Graphics::Position.new(21, 11)
#tool = Graphics::Tool.new image, ["../img/normal_elements/wall.gif", "../img/toolbox_clicked/wall.gif"]
#toolbox = Graphics::ToolBox.new "Tool Box", Graphics::Position.new(10, 1)
#toolbox.add_tool tool
window = Graphics::Window.new
window.draw tool_box
#window.draw border
#window.draw border1
#window.draw image
#window.draw caption
window.render_as(Graphics::Renderers::ShoesGUI)
#puts window.render_as(Graphics::Renderers::Console)