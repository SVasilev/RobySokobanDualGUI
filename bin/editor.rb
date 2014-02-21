require_relative '../lib/sokoban/load_data'
require_relative '../lib/sokoban/editor'

Sokoban.require_files
#RENDERER = Graphics::Renderers::Console
RENDERER = Graphics::Renderers::ShoesGUI

Sokoban.editor RENDERER