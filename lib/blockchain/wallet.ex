defmodule ExCoins.Blockchain.Wallet do
  @moduledoc """
  Wallet structure and basic functions
  """

  defstruct [:address, :private_key]

  @type t :: %__MODULE__{
    address: String.t,
    private_key: String.t
  }
end
