defmodule Offshore.Intermediary do
  use Offshore.Web, :model

  schema "intermediaries" do
    field :name, :string
    field :internal_id, :string
    field :address, :string
    field :valid_until, :string
    field :country_codes, :string
    field :countries, :string
    field :status, :string
    field :node_id, :integer
    field :sourceID, :string

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :internal_id, :address, :valid_until, :country_codes, :countries, :status, :node_id, :sourceID])
    |> validate_required([:node_id])
    |> unique_constraint(:node_id)
  end
end
