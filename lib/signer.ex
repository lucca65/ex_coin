defmodule ExCoin.Signer do
  def run(message \\ "hello") do
    curve = :secp256k1
    {public_key, private_key} = :crypto.generate_key(:ecdh, curve)

    signature = :crypto.sign(:ecdsa, :sha256, message, [private_key, curve])
    valid? = :crypto.verify(:ecdsa, :sha256, message, signature, [public_key, curve])
    valid?
  end
end
