require_relative '../lib/sokoban/load_data'
require_relative '../lib/sokoban/game'

Sokoban.require_files
#RENDERER   = Graphics::Renderers::Console
RENDERER   = Graphics::Renderers::ShoesGUI
LEVEL_PATH = "C:/Users/Sopata/Desktop/ime.txt"

#I tried to make RENDERER and LEVEL_PATH to be parsed as arguments in the console but it didnt work because Shoes does not recognize ARGV[0] and ARGV[1]
Sokoban.game RENDERER, LEVEL_PATH