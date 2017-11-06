defmodule ExCoins.Blockchain.Transfer do
  @moduledoc """
  Defines a basic transfer operation

  ```
  %Transfer{
    senderKey: "public key of transaction issuer",
    recipient: "address of the recipient",
    amount: 100_000,
  }
  ```
  """

  defstruct [:senderKey, :recipient, :amount]

  @type t :: %__MODULE__{
    senderKey: String.t,
    recipient: String.t,
    amount: Integer.t
  }

  alias ExCoins.Blockchain.Transfer

  def to_json(%Transfer{} = transfer) do
    Poison.encode(transfer)
  end
end
