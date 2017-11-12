defmodule ExCoin.ProofOfWork do
  @moduledoc false

  alias ExCoin.Blockchain
  alias ExCoin.Blockchain.Block

  def miner_block(blockchain, block) do
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
    |> calculate_0_sequence()

    hash
    |> calculate_0_prefix()
    |> Kernel.>=(sequences)
  end

  def calculate_0_sequence(difficulty) when is_integer(difficulty) and difficulty > 0 do
    log2 = :math.log(2)
    difficulty
    |> :math.log()
    |> Kernel.*(log2)
    |> round()
  end

  def calculate_0_prefix(hash) when is_bitstring(hash) do
    hash
    |> String.split("")
    |> calculate_0_prefix(0)
  end
  def calculate_0_prefix(["0"|tail], acc), do: calculate_0_prefix(tail, acc + 1)
  def calculate_0_prefix(_notInit0, acc), do: acc

end
