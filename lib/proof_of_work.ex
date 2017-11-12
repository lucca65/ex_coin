defmodule ExCoin.ProofOfWork do
  @moduledoc false

  alias ExCoin.Blockchain
  alias ExCoin.Blockchain.Block

  def minerBlock(blockchain, block) do
    is_valid? = blockchain
    |> verify(block)
    if is_valid? do
      block
    else
      new_block = block
      |> Block.update_nonce(block.nonce + 1)

      blockchain
      |> minerBlock(new_block)
    end
  end

  def verify(%Blockchain{difficulty: difficulty}, %Block{hash: hash}) do
    sequences = difficulty
    |> calculate0Sequence()

    hash
    |> calculate0Sequence()
    |> Kernel.>=(sequences)
  end

  def calculate0Sequence(difficulty) do
    log2 = :math.log(2)
    difficulty
    |> :math.log()
    |> Kernel.*(log2)
    |> round()
  end

  def calculate0Prefix(hash) do
    hash
    |> String.split()
    |> calculate0Prefix(0)
  end
  def calculate0Prefix(["0"|tail], acc), do: calculate0Prefix(tail, acc + 1)
  def calculate0Prefix(_notInit0, acc), do: acc

end
