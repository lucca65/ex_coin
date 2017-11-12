defmodule ExCoin.Blockchain do
  @moduledoc """
  Blockchain is a monotonically increasing chain of blocks in which subsequent blocks are verified based on the data of preceding blocks the chain


  - address: a unique base58 encoded value representing a public_key in the network
  - ledger: a mapping of address and balances
  - transaction: a struct represeting a single atomic modifications to the ledger with some extra data to prove validity
  - block: a list of ordered transaction with some extra data to prove validity
  """

  defstruct [:address, :difficulty, :transaction, :block, :ledger]
end
