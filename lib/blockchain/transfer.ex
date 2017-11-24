defmodule ExCoin.Blockchain.Transfer do
  @moduledoc """
  Defines a basic transfer operation

  ```
  %Transfer{
    sender: "address (public key) of transaction issuer",
    recipient: "address (public key) of the recipient",
    amount: 100_000,
    nounce: "all time number of transactions made by the sender"
  }
  ```
  """

  defstruct ~w(sender recipient amount nounce)a

  @type t :: %__MODULE__{
    sender: String.t,
    recipient: String.t,
    amount: Integer.t,
    nounce: Integer.t,
  }

  alias ExCoin.Blockchain.Transfer

  def to_json(%Transfer{} = transfer) do
    Poison.encode(transfer)
  end
end
