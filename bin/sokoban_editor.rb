require_relative '../lib/graphics/window'
require_relative '../lib/graphics/renderers'
require_relative '../lib/graphics/position'
require_relative '../lib/graphics/border'

border = Graphics::Border.new Graphics::Position.new(10, 10), Graphics::Position.new(39, 20)
window = Graphics::Window.new
window.draw border
window.render_as(Graphics::Renderers::ShoesGUI)
#puts window.render_as(Graphics::Renderers::Console)