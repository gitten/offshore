defmodule Offshore.Edge do
  use Offshore.Web, :model

  schema "edges" do
    field :node_1, :integer
    field :rel_type, :string
    field :node_2, :integer

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:node_1, :rel_type, :node_2])
    |> validate_required([:node_1, :rel_type, :node_2])
  end
end
