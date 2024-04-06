defmodule GHTest do
  use ExUnit.Case
  doctest GH

  test "greets the world" do
    assert GH.hello() == :world
  end
end
