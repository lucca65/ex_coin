defmodule ExCoin.MerkleTree.Node do
  @moduledoc """
  Merkle tree node
  """

  defstruct [:value, :children, :height]

  @type t :: %__MODULE__{
    value: String.t,
    children: [__MODULE__.t],
    height: non_neg_integer
  }
end
