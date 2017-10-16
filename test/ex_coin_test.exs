defmodule ExCoinTest do
  use ExUnit.Case
  doctest ExCoin

  test "greets the world" do
    assert ExCoin.hello() == :world
  end
end
