defmodule ExCoin.Block do
  defstruct [:index, :previous_hash, :timestamp, :data, :nounce, :hash]

  @type t :: %__MODULE__{
    index: Integer.t,
    previous_hash: String.t,
    timestamps: {Integer.t, Integer.t, Integer.t},
    data: String.t,
    nounce: Integer.t,
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

  def hash_block(%Block{index: i, previous_hash: h, timestamp: timestamp, data: d, nounce: n}) do
    "#{i}#{h}#{timestamp}#{d}#{n}"
    |> ExCoin.hash()
  end
end
