defmodule ExCoin.Blockchain.Transaction do
  @moduledoc """
  Defines a transaction struct and related functions

  A transaction define an atomic **ledger** state modification

  Simple implementation that only allows transfer. Defined by

  ```
  %Transaction{
    transfer: %Transfer{},
    timestamp: {1509, 931186, 658718},
    public_key: ""
    signature: "" # signed transaction hash
  }
  ```
  """

  defstruct [:transfer, :timestamp, :public_key, :signature]

  alias ExCoin.Blockchain.{Transaction, Transfer}

  @type t :: %__MODULE__{
    transfer: Transfer.t,
    timestamp: {Integer.t, Integer.t, Integer.t},
    public_key: String.t,
    signature: String.t
  }

  def to_string(%Transaction{public_key: pk} = transaction) do
    "#{Transfer.to_json(transaction)}#{pk}"
  end
end
