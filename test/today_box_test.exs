defmodule TodayBoxTest do
  use ExUnit.Case
  doctest TodayBox

  test "greets the world" do
    assert TodayBox.hello() == :world
  end
end
