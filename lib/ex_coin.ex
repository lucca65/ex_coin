defmodule ExCoin do
  @moduledoc """
  Documentation for ExCoin.
  """

  @docs"""
  Hash a value with SHA_256
  """
  @spec hash(String.t) :: String.t
  def hash(data) do
    :crypto.hash(:sha256, data) |> Base.encode16(case: :lower)
  end

end
