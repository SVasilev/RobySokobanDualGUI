require_relative '../../lib/sokoban/position'
require_relative '../../lib/sokoban/border'
require_relative '../helper'

describe "Sokoban" do
  it "is declared as top level constant" do
    Object.constants.must_include :Sokoban
  end

  describe "Position" do
    let (:position) { Sokoban::Position.new(5, 12) }

    it "is a member of module Sokoban" do
      Sokoban.constants.must_include :Position
    end

    it "creates position without arguments" do
      Sokoban::Position.new.x.must_equal 0
      Sokoban::Position.new.y.must_equal 0
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
    let (:border) { Sokoban::Border.new Sokoban::Position.new(2, 2), Sokoban::Position.new(10, 6), 5, "ABC", 4 }

    it "is a member of Sokoban module" do
      Sokoban.constants.must_include :Border
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