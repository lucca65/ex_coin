defmodule ExCoin.ProofOfWorkTest do
  use ExUnit.Case
  doctest ExCoin

  alias ExCoin.{ProofOfWork, Blockchain}
  alias ExCoin.Blockchain.Block

  setup do
    {:ok, %{
        blockchain: %Blockchain{difficulty: 10},
        invalid: %Block{index: 0, data: "", nonce: 0, hash: ""},
        valid: %Block{index: 0, data: "", nonce: 563, hash: "00e23adbc0a8c69c24b0f8382ba088733a21415bd3053d7cecb31a99a0779db2"}
     }}
  end

  test "calculate number of 0 in hash prefix" do
    assert ProofOfWork.calculate_0_prefix("01234567") === 1
    assert ProofOfWork.calculate_0_prefix("00012345") === 3
    assert ProofOfWork.calculate_0_prefix("12345000") === 0
  end

  test "calculate number of 0 in prefix from difficulty" do
    assert ProofOfWork.calculate_0_sequence(1) === 0
    assert ProofOfWork.calculate_0_sequence(100) === 3
    assert ProofOfWork.calculate_0_sequence(100_000_000) === 13
  end

  test "verify block from proof of work", %{blockchain: blockchain, invalid: invalid, valid: valid} do
    assert ProofOfWork.verify(blockchain, valid)
    refute ProofOfWork.verify(blockchain, invalid)
  end

  test "miner new block", %{blockchain: blockchain, invalid: invalid, valid: valid} do
    assert ProofOfWork.miner_block(blockchain, invalid) === valid
  end

end
