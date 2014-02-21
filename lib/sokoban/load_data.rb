module Sokoban
  def self.set_toolbox_image_paths
    [["../img/toolbox_normal/wall.gif", "../img/toolbox_clicked/wall.gif"], ["../img/toolbox_normal/cube.gif", "../img/toolbox_clicked/cube.gif"],
    ["../img/toolbox_normal/final.gif", "../img/toolbox_clicked/final.gif"], ["../img/toolbox_normal/smiley.gif", "../img/toolbox_clicked/smiley.gif"],
    ["../img/toolbox_normal/eraser.gif", "../img/toolbox_clicked/eraser.gif"]]
  end
  
  def self.set_ground_image_paths
    ["../img/normal_elements/wall.gif", "../img/normal_elements/cube.gif", "../img/normal_elements/final.gif", "../img/normal_elements/smiley.gif", "../img/normal_elements/empty.gif"]
  end

  def self.require_files
    require_relative '../graphics/window'
    require_relative '../graphics/renderers'
    require_relative '../graphics/position'
    require_relative '../graphics/border'
    require_relative '../graphics/image'
    require_relative '../graphics/caption'
    require_relative '../graphics/toolbox'
    require_relative '../graphics/button'
    require_relative '../graphics/menu'
    require_relative '../graphics/ground'
    require_relative '../graphics/player'
  end
end