defmodule ExCoin.Signer do
  @curve :secp256k1
  def sign(message) do
    {public_key, private_key} = :crypto.generate_key(:ecdh, @curve)

    signature = :crypto.sign(:ecdsa, :sha256, message, [private_key, @curve])
    {message, signature, public_key}
  end

  def is_valid?({ message, signature, public_key }) do
    :crypto.verify(:ecdsa, :sha256, message, signature, [public_key, @curve])
  end

  def run(message) do
    message
    |> sign()
    |> is_valid?()
  end
end
