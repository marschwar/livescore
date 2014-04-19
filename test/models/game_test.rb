require 'test_helper'

class GameTest < ActiveSupport::TestCase
  setup do
    @game = Game.new
  end

  test "calculation home score for new game" do
    assert_equal 0, @game.total_home
  end

  test "calculation home score for started" do
    @game.home_quarter_1 = 7
    @game.home_quarter_2 = 10
    @game.home_quarter_3 = 13
    @game.home_quarter_4 = 3
    assert_equal 33, @game.total_home
    assert_equal 0, @game.total_away
  end
end
