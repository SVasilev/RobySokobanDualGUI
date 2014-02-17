require_relative '../../lib/graphics/window'
require_relative '../../lib/graphics/renderers'
require_relative '../../lib/graphics/position'
require_relative '../../lib/graphics/border'
require_relative '../../lib/graphics/image'
require_relative '../../lib/graphics/caption'
require_relative '../../lib/graphics/tool'
require_relative '../../lib/graphics/toolbox'
require_relative '../../lib/sokoban/game'
require_relative '../helper'

describe "Sokoban" do
  it "is declared as top level constant" do
    Object.constants.must_include :Sokoban
  end
end

describe "Graphics" do
  it "is declared as top level constant" do
    Object.constants.must_include :Graphics
  end

  describe "Window" do
    let (:window) { Graphics::Window.new(20, 30) }

    it "is a member of module Graphics" do
      Graphics.constants.must_include :Window
    end

    it "allows accessing attributes" do
      window.width.must_equal 20
      window.height.must_equal 30
    end

    it "checks if coordinates for the pixel are acceptable" do
      window.set_pixel Graphics::Position.new(30, 30), :border
      window.pixel_type(Graphics::Position.new 30, 30).must_equal nil
    end

    it "sets pixels with exact type" do
      window.set_pixel Graphics::Position.new(10, 20), :border
      window.pixel_type(Graphics::Position.new 10, 20).must_equal :border
      window.pixel_type(Graphics::Position.new 10, 10).must_equal nil
    end

    it "allows drawing in window" do
      window.draw(Graphics::Border.new(Graphics::Position.new(2, 2), Graphics::Position.new(6, 4)))
      window.contents.keys.must_equal   [[2, 2], [3, 2], [4, 2], [5, 2], [6, 2], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [2, 3], [6, 3]]
      window.contents.values.must_equal [:border, :border, :border, :border, :border, :border, :border, :border, :border, :border, :border, :border]
    end

    it "clears window correctly" do
      window.draw(Graphics::Border.new(Graphics::Position.new(2, 2), Graphics::Position.new(6, 4)))
      window.clear
      window.contents.values.must_equal [" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "]
    end
  end

  describe "Renderers" do
    it "is a member of module Graphics" do
      Graphics.constants.must_include :Renderers
    end

    let (:border)         { Graphics::Border.new Graphics::Position.new(2, 2), Graphics::Position.new(6, 4) }
    let (:another_border) { Graphics::Border.new Graphics::Position.new(1, 3), Graphics::Position.new(9, 9) }
    let (:wall_image)     { Graphics::Image.new "D:/Programming/Ruby/Ruby Sokoban Project/RobySokobanDualGUI/img/toolbox_normal/cube.gif", Graphics::Position.new(2, 7) }
    let (:window)         { Graphics::Window.new(10, 10) }


    describe "Console" do
      it "is a member of module Renderers" do
        Graphics::Renderers.constants.must_include :Console
      end

      it "renders borders correctly" do
        window.draw border
        window.render_as(Graphics::Renderers::Console).must_equal "          \n          \n  .....   \n  .   .   \n  .....   \n          \n          \n          \n          \n          \n"
      end

      it "allows drawing images" do
        window.draw wall_image
        window.render_as(Graphics::Renderers::Console).must_equal "          \n          \n          \n          \n          \n          \n          \n  C       \n          \n          \n"
      end
    end

    describe "ShoesGUI" do
      it "is a member of module Renderers" do
        Graphics::Renderers.constants.must_include :ShoesGUI
      end

      it "scales coordinates correctly" do
        Graphics::Renderers::ShoesGUI.scale_x(5).must_equal 63.25
        Graphics::Renderers::ShoesGUI.scale_y(5).must_equal 75
      end

      it "extracts points for borders correctly" do
        window.draw border
        window.draw another_border
        Graphics::Renderers::ShoesGUI.extract_border_points(window).map(&:first).map { |position| [position.x, position.y] }.must_equal [[2, 2], [2, 2], [3, 2], [3, 2], [4, 2], [4, 2], [5, 2], [5, 2], [6, 2], [1, 3], [1, 3], [2, 3], [2, 3], [3, 3], [3, 3], [4, 3], [4, 3], [5, 3], [5, 3], [6, 3], [6, 3], [7, 3], [8, 3], [9, 3], [1, 4], [1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [9, 4], [1, 5], [9, 5], [1, 6], [9, 6], [1, 7], [9, 7], [1, 8], [9, 8], [1, 9], [2, 9], [3, 9], [4, 9], [5, 9], [6, 9], [7, 9], [8, 9]]
        window.clear
      end
    end
  end

  describe "Position" do
    let (:position) { Graphics::Position.new(5, 12) }

    it "is a member of module Graphics" do
      Graphics.constants.must_include :Position
    end

    it "creates position without arguments" do
      Graphics::Position.new.x.must_equal 0
      Graphics::Position.new.y.must_equal 0
    end

    it "works with readers" do
      position.x.must_equal 5
      position.y.must_equal 12
    end

    it "works with writers" do
      position.x = 10
      position.y = 20
      position.x.must_equal 10
      position.y.must_equal 20
    end
  end

  describe "Border" do
    let (:border) { Graphics::Border.new Graphics::Position.new(2, 2), Graphics::Position.new(6, 4) }

    it "is a member of Graphics module" do
      Graphics.constants.must_include :Border
    end

    it "allows reading the class variables" do
      border.top_left.x.must_equal 2
      border.top_left.y.must_equal 2
      border.bottom_right.x.must_equal 6
      border.bottom_right.y.must_equal 4
    end

    it "calculates bottom_left point" do
      border.bottom_left.x.must_equal 2
      border.bottom_left.y.must_equal 4
    end

    it "calculates top_right point" do
      border.top_right.x.must_equal 6
      border.top_right.y.must_equal 2
    end

    it "renders correctly" do
      border.render_array.map(&:first).map { |element| [element.x, element.y] }.must_equal [[2, 2], [3, 2], [4, 2], [5, 2], [6, 2], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [2, 3], [6, 3]]
    end
  end

  describe "Image" do
    let (:image) { Graphics::Image.new "../img/normal_elements/wall.gif", Graphics::Position.new(20, 30), 50, 60 }

    it "is a member of Graphics module" do
      Graphics.constants.must_include :Image
    end

    it "allows reading width and height" do
      image.width.must_equal 50
      image.height.must_equal 60
    end

    it "allows accessing file_path" do
      image.file_path = "../normal_elements/cube.gif"
      image.file_path.must_equal "../normal_elements/cube.gif"
      image.file_path = "../normal_elements/wall.gif"
    end

    it "renders_correctly" do
      image.render_array.first.first.x.must_equal 20
      image.render_array.first.first.y.must_equal 30
      image.render_array.first.last.must_equal "../img/normal_elements/wall.gif"
    end
  end

  describe "Caption" do
    let (:caption) { Graphics::Caption.new "Tool Box", Graphics::Position.new(20, 30) }

    it "is a member of Graphics module" do
      Graphics.constants.must_include :Caption
    end

    it "renders_correctly" do
      caption.render_array.first.first.x.must_equal 20
      caption.render_array.first.first.y.must_equal 30
      caption.render_array.map(&:last).join.must_equal "Tool Box"
    end
  end

  describe "Tool" do
    let (:image) { Graphics::Image.new "../img/normal_elements/wall.gif", Graphics::Position.new(10, 20), 20, 10 }
    let (:tool) { Graphics::Tool.new image, ["../graphics/normal_elements/wall.gif", "../graphics/toolbox_clicked/wall.gif"] }

    it "is a member of Graphics module" do
      Graphics.constants.must_include :Tool
    end

    it "allows switching pictures" do
      tool.image.file_path = tool.load_paths.last
      tool.image.file_path.must_equal "../graphics/toolbox_clicked/wall.gif"
    end
  end

  describe "ToolBox" do
    it "is a member of Graphics module" do
      Graphics.constants.must_include :ToolBox
    end
  end
end