defmodule ExCoin.Signer do
  @moduledoc """
  Simple wrapper of the :crypto module.
  Used mainly for experimentation
  """

  @curve :secp256k1

  @doc """
  Just sample function for experimentation
  """
  def run(message) do
    {public_key, private_key} = :crypto.generate_key(:ecdh, @curve)
    run(message, public_key, private_key)
  end

  @doc """
  Just sample function for experimentation
  """
  def run(message, public_key, private_key) do
    signature = sign(message, private_key)

    if is_valid?(message, signature, public_key) do
      signature
    else
      {:error, :invalid_signature}
    end
  end

  def sign(message, private_key) do
    :crypto.sign(:ecdsa, :sha256, message, [private_key, @curve])
  end

  def is_valid?(message, signature, public_key) do
    :crypto.verify(:ecdsa, :sha256, message, signature, [public_key, @curve])
  end

end
