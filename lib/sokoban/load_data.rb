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
    require_relative 'position.rb'
    require_relative 'border.rb'
    require_relative 'tool.rb'
    require_relative 'toolbox.rb'
    require_relative 'ground.rb'
    require_relative 'player.rb'
    require_relative 'menu.rb'
    require_relative 'game.rb'
    require_relative 'dropdown_menu.rb'
  end
end