defmodule ExCoin.MerkleTree do
  alias ExCoin.MerkleTree.Node
  defstruct [:root, :blocks]

  @number_of_children 2

  @type t :: %__MODULE__{
    root: Node.t,
    blocks: [String.t, ...]
  }

  def new(blocks) when blocks != [] do
    unless is_power_of_n(@number_of_children, Enum.count(blocks)) do
      raise %ArgumentError{message: "must be power of #{@number_of_children}"}
    end

    root = build(blocks)
    %__MODULE__{root: root, blocks: blocks}
  end

  def build(blocks) do
    initial_height = 0
    Enum.map(blocks, &build_first_block/1)
    |> build_tree(initial_height)
  end

  def build_first_block(block) do
    %Node{
      value: ExCoin.hash(block),
      children: [],
      height: 0
    }
  end

  def build_tree([root], _), do: root
  def build_tree(nodes, height) do
    children = Enum.chunk_every(nodes, @number_of_children)
    parents = Enum.map(children, fn (partition) ->
      concatenated =
        partition
        |> Enum.map(&(&1.value))
        |> Enum.reduce("", &(&2 <> &1))

      # Parent node hash is calculated by the concat of its children
      %Node{
        value: ExCoin.hash(concatenated),
        children: partition,
        height: height + 1
      }
    end)
    build_tree(parents, height + 1)
  end

  def is_power_of_n(n, blocks) do
    (:math.log2(blocks) / :math.log2(n))
    |> ( fn x -> Float.ceil(x) == Float.floor(x) end ).()
  end
end
