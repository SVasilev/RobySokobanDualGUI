require_relative '../../lib/graphics/window'
require_relative '../../lib/graphics/position'
require_relative '../../lib/graphics/border'
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
    let (:window) { Graphics::Window.new(20, 20) }

    it "is a member of module Sokoban" do
      Graphics.constants.must_include :Window
    end

    it "checks if coordinates for the pixel are acceptable" do
      window.set_pixel 30, 30, :border
      window.pixel_type(30, 30).must_equal nil
    end

    it "sets pixels with exact type" do
      window.set_pixel 10, 20, :border
      window.pixel_type(10, 20).must_equal :border
      window.pixel_type(10, 10).must_equal nil
    end
  end

  describe "Position" do
    let (:position) { Graphics::Position.new(5, 12) }

    it "is a member of module Sokoban" do
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
    let (:border) { Graphics::Border.new Graphics::Position.new(2, 2), Graphics::Position.new(10, 6), 5, "ABC", 4 }

    it "is a member of Sokoban module" do
      Graphics.constants.must_include :Border
    end

    it "allows reading the padding" do
      border.padding.must_equal 5
    end

    it "calculates bottom_left point" do
      border.bottom_left.x.must_equal 2
      border.bottom_left.y.must_equal 6
    end

    it "calculates top_right point" do
      border.top_right.x.must_equal 10
      border.top_right.y.must_equal 2
    end
  end
end