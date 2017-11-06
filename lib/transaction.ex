defmodule ExCoin.Transaction do
  @moduledoc """
  Defines a transaction struct and related functions

  A transaction define an atomic **ledger** state modification

  Simple implementation that only allows transfer. Defined by

  ```
  %Transaction{
    transfer: %Transfer{},
    timestamp: {1509, 931186, 658718},
    signature: "" # signed transaction hash
  }
  ```
  """

  defstruct [:transfer, :timestamp, :signature]

  alias ExCoin.Transaction

  @type t :: %__MODULE__{
    transfer: Transfer.t,
    timestamp: {Integer.t, Integer.t, Integer.t},
    signature: String.t
  }

  def to_string(%Transaction{} = transaction) do
  end
end
