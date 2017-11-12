defmodule ExCoin.Blockchain.Block do
  defstruct [:index, :previous_hash, :timestamp, :data, :nonce, :hash]

  alias ExCoin.Blockchain.Block

  @type t :: %__MODULE__{
    index: Integer.t,
    previous_hash: String.t,
    timestamp: {Integer.t, Integer.t, Integer.t},
    data: String.t,
    nonce: Integer.t,
    hash: String.t
  }

  def next_block(data, lastest_block) do
    block =
      %Block{
        index: lastest_block.index + 1,
        previous_hash: lastest_block.hash,
        timestamp: :os.timestamp(),
        data: data
      }
    %{block | hash: hash_block(block)}
  end

  def update_nonce(block, nonce) do
    hash = %{block | nonce: nonce}
    |> hash_block()
    %{block | hash: hash, nonce: nonce}
  end

  def hash_block(%Block{index: i, previous_hash: h, timestamp: timestamp, data: d, nonce: n}) do
    "#{i}#{h}#{timestamp}#{d}#{n}"
    |> ExCoin.Signer.hash()
  end

end
