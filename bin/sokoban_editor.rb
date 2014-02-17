require_relative '../lib/graphics/window'
require_relative '../lib/graphics/renderers'
require_relative '../lib/graphics/position'
require_relative '../lib/graphics/border'

border = Graphics::Border.new Graphics::Position.new(1, 1), Graphics::Position.new(10, 10)
border1 = Graphics::Border.new Graphics::Position.new(20, 10), Graphics::Position.new(30, 20)
window = Graphics::Window.new
window.draw border
window.draw border1
window.render_as(Graphics::Renderers::ShoesGUI)
#puts window.render_as(Graphics::Renderers::Console)