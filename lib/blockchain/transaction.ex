defmodule ExCoin.Blockchain.Transaction do
  @moduledoc """
  Defines a transaction struct and related functions

  A transaction define an atomic **ledger** state modification

  Simple implementation that only allows transfer. Defined by

  ```
  %Transaction{
    transfer: %Transfer{},
    public_key: "Address of sender"
    signature: "signed transaction hash"
  }
  ```
  """

  defstruct [:transfer, :public_key, :signature]

  alias ExCoin.Signer
  alias ExCoin.Blockchain.{Transaction, Transfer}

  @type t :: %__MODULE__{
    transfer: Transfer.t,
    public_key: String.t,
    signature: String.t
  }

  @doc """
  Signs a transaction using given private key

  - Grab transaction transfer details
  - Hash the transfer
  - Sign it using private key
  - Return whole transaction, signature included
  """
  def sign(%Transaction{} = transaction, private_key) do
    signature =
      transaction
      |> Map.get(:transfer)
      |> Transfer.to_json()
      |> Signer.hash()
      |> Signer.sign(private_key)

    %{
      transaction |
      signature: signature,
    }
  end
end
