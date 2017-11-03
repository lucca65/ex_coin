defmodule ExCoin.Merkle do
  alias ExCoin.Merkle.Node

  @number_of_children 2

  def build(blocks) do
    leaves = Enum.map(blocks, fn (block) ->
      %Node{
        value: ExCoin.hash(block),
        children: []
      }
    end)
    build_tree(leaves)
  end

  def build_tree([root], _), do: root
  def build_tree(nodes) do
    children = Enum.chunk_every(nodes, @number_of_children)
    parents = Enum.map(children, fn (partition) ->
      concatenated =
        partition
        |> Enum.map(&(&1.value))
        |> Enum.reduce("", &(&2 <> &1))

      %Node{
        value: ExCoin.hash(concatenated),
        children: partition
      }
    end)
    build_tree(parents)
  end
end