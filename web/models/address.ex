defmodule Offshore.Address do
  use Offshore.Web, :model

  schema "addresses" do
    field :address, :string
    field :icij_id, :string
    field :valid_until, :string
    field :country_codes, :string
    field :countries, :string
    field :node_id, :integer
    field :sourceID, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:address, :icij_id, :valid_until, :country_codes, :countries, :node_id, :sourceID])
    |> validate_required([:address, :valid_until, :node_id, :sourceID])
    |> unique_constraint(:node_id)
  end
end
