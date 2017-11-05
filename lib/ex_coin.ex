defmodule ExCoin do
  @moduledoc """
  Documentation for ExCoin.
  """

  @doc """
  Hash a value with SHA_256
  """
  @spec hash(String.t) :: String.t
  def hash(data) do
    :sha256
    |> :crypto.hash(data)
    |> Base.encode16(case: :lower)
  end
end
