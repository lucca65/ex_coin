defmodule ExCoin.Merkle.Node do
  @moduledoc """
  Merkle tree node
  """

  defstruct [:value, :children]

  @type t :: %ExCoin.Merkle.Node{
    value: String.t,
    children: [ExCoin.Merkle.Node.t]
  }
end
