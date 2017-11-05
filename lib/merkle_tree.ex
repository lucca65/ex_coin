defmodule ExCoin.MerkleTree do
  alias ExCoin.MerkleTree.Node
  defstruct [:root, :blocks]

  @number_of_children 2

  @type t :: %__MODULE__{
    root: Node.t,
    blocks: [String.t, ...]
  }

  def new(blocks) when blocks != [] do
    root = build(blocks)
    %__MODULE__{root: root, blocks: blocks}
  end

  def build(blocks) do
    Enum.map(blocks, &build_block/1)
    |> build_tree()
  end

  def build_block(block) do
    %Node{
      value: ExCoin.hash(block),
      children: []
    }
  end

  def build_tree([root]), do: root
  def build_tree(nodes) do
    children = Enum.chunk_every(nodes, @number_of_children)
    parents = Enum.map(children, fn (partition) ->
      concatenated =
        partition
        |> Enum.map(&(&1.value))
        |> Enum.reduce("", &(&2 <> &1))

      # Parent node hash is calculated by the concat of its children
      %Node{
        value: ExCoin.hash(concatenated),
        children: partition
      }
    end)
    build_tree(parents)
  end
end
