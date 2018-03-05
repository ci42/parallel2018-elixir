defmodule ExampleTest do
  use ExUnit.Case
  doctest Example
  doctest HelloExtended

  test "greets the world" do
    assert Example.hello() == :world
  end
end
